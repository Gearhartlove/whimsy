defmodule WhimsyWeb.UserSettingsController do
  use WhimsyWeb, :controller

  alias Whimsy.Accounts
  alias WhimsyWeb.UserAuth

  import WhimsyWeb.UserAuth, only: [require_sudo_mode: 2]

  plug :require_sudo_mode
  plug :assign_changesets

  def edit(conn, _params) do
    render(conn, :edit)
  end

  @avatar_upload_dir Path.join([:code.priv_dir(:whimsy), "static", "uploads", "avatars"])
  @allowed_extensions ~w(.jpg .jpeg .png .gif .webp)
  @max_file_size 2 * 1024 * 1024

  def update(conn, %{"action" => "update_avatar"} = params) do
    user = conn.assigns.current_scope.user

    case resolve_avatar_params(params, user) do
      {:ok, avatar_path} ->
        case Accounts.update_user_avatar(user, %{avatar_path: avatar_path}) do
          {:ok, _user} ->
            conn
            |> put_flash(:info, "Avatar updated successfully.")
            |> redirect(to: ~p"/users/settings")

          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Failed to update avatar.")
            |> redirect(to: ~p"/users/settings")
        end

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> redirect(to: ~p"/users/settings")
    end
  end

  def update(conn, %{"action" => "update_name"} = params) do
    %{"user" => user_params} = params
    user = conn.assigns.current_scope.user

    case Accounts.update_user_name(user, user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Name updated successfully.")
        |> redirect(to: ~p"/users/settings")

      {:error, changeset} ->
        render(conn, :edit, name_changeset: changeset)
    end
  end

  def update(conn, %{"action" => "update_email"} = params) do
    %{"user" => user_params} = params
    user = conn.assigns.current_scope.user

    case Accounts.change_user_email(user, user_params) do
      %{valid?: true} = changeset ->
        Accounts.deliver_user_update_email_instructions(
          Ecto.Changeset.apply_action!(changeset, :insert),
          user.email,
          &url(~p"/users/settings/confirm-email/#{&1}")
        )

        conn
        |> put_flash(
          :info,
          "A link to confirm your email change has been sent to the new address."
        )
        |> redirect(to: ~p"/users/settings")

      changeset ->
        render(conn, :edit, email_changeset: %{changeset | action: :insert})
    end
  end

  def update(conn, %{"action" => "update_password"} = params) do
    %{"user" => user_params} = params
    user = conn.assigns.current_scope.user

    case Accounts.update_user_password(user, user_params) do
      {:ok, {user, _}} ->
        conn
        |> put_flash(:info, "Password updated successfully.")
        |> put_session(:user_return_to, ~p"/users/settings")
        |> UserAuth.log_in_user(user)

      {:error, changeset} ->
        render(conn, :edit, password_changeset: changeset)
    end
  end

  def confirm_email(conn, %{"token" => token}) do
    case Accounts.update_user_email(conn.assigns.current_scope.user, token) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Email changed successfully.")
        |> redirect(to: ~p"/users/settings")

      {:error, _} ->
        conn
        |> put_flash(:error, "Email change link is invalid or it has expired.")
        |> redirect(to: ~p"/users/settings")
    end
  end

  defp assign_changesets(conn, _opts) do
    user = conn.assigns.current_scope.user

    conn
    |> assign(:avatar_changeset, Accounts.change_user_avatar(user))
    |> assign(:name_changeset, Accounts.change_user_name(user))
    |> assign(:email_changeset, Accounts.change_user_email(user))
    |> assign(:password_changeset, Accounts.change_user_password(user))
  end

  defp resolve_avatar_params(%{"avatar_upload" => %Plug.Upload{} = upload}, user) do
    ext = Path.extname(upload.filename) |> String.downcase()

    cond do
      ext not in @allowed_extensions ->
        {:error, "Invalid file type. Allowed: jpg, png, gif, webp."}

      File.stat!(upload.path).size > @max_file_size ->
        {:error, "File too large. Maximum size is 2MB."}

      true ->
        File.mkdir_p!(@avatar_upload_dir)
        filename = "#{user.id}_#{System.os_time(:millisecond)}#{ext}"
        dest = Path.join(@avatar_upload_dir, filename)
        File.cp!(upload.path, dest)
        delete_old_upload(user.avatar_path)
        {:ok, "/uploads/avatars/#{filename}"}
    end
  end

  defp resolve_avatar_params(%{"avatar_preset" => preset}, user)
       when is_binary(preset) and preset != "" do
    if String.starts_with?(preset, "/images/avatars/") do
      delete_old_upload(user.avatar_path)
      {:ok, preset}
    else
      {:error, "Invalid preset avatar."}
    end
  end

  defp resolve_avatar_params(%{"remove_avatar" => "true"}, user) do
    delete_old_upload(user.avatar_path)
    {:ok, nil}
  end

  defp resolve_avatar_params(_params, _user) do
    {:error, "No avatar change specified."}
  end

  defp delete_old_upload(nil), do: :ok

  defp delete_old_upload("/uploads/avatars/" <> _ = path) do
    full_path = Path.join([:code.priv_dir(:whimsy), "static", path])
    File.rm(full_path)
  end

  defp delete_old_upload(_), do: :ok
end
