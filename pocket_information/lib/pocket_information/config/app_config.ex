defmodule PocketInformation.Config.AppConfig do
  def get_port do
    :pocket_information |> Application.get_env(:port, 8081)
  end

  def basic_auth_username do
    :pocket_information |> Application.get_env(:basic_auth_username)
  end

  def basic_auth_password do
    :pocket_information |> Application.get_env(:basic_auth_password)
  end

  def server_public_certificate_path do
    :pocket_information |> Application.get_env(:server_public_certificate_path)
  end

  def server_private_key_path do
    :pocket_information |> Application.get_env(:server_private_key_path)
  end

  def server_private_passphrase do
    :pocket_information |> Application.get_env(:server_private_passphrase)
  end

  def castore_path do
    :pocket_information |> Application.get_env(:castore_path)
  end

  def get_db_host do
    :pocket_information |> Application.get_env(:db_host)
  end

  def get_db_port do
    :pocket_information |> Application.get_env(:db_port)
  end

  def get_db_user do
    :pocket_information |> Application.get_env(:db_username)
  end

  def get_db_password do
    :pocket_information |> Application.get_env(:db_password)
  end

  def get_db_name do
    :pocket_information |> Application.get_env(:db_name)
  end

  def get_db_pool_size do
    :pocket_information |> Application.get_env(:db_pool_size)
  end

  def get_db_pocket_collection do
    :pocket_information |> Application.get_env(:db_pocket_collection)
  end

  def get_db_category_collection do
    :pocket_information |> Application.get_env(:db_category_collection)
  end

  def get_db_category_collection do
    :pocket_information |> Application.get_env(:db_category_collection)
  end

  def db_use_ssl do
    :pocket_information |> Application.get_env(:db_use_ssl)
  end

  def db_verify_cer do
   if (:pocket_information |> Application.get_env(:db_verify_cer)) do
     :verify_peer
     else
     :verify_none
   end
  end

  def db_auth_source do
    :pocket_information |> Application.get_env(:db_auth_source)
  end

  def db_public_certificate do
    :pocket_information |> Application.get_env(:db_public_certificate)
  end

  def db_private_certificate do
    :pocket_information |> Application.get_env(:db_private_certificate)
  end

  def db_castore do
    :pocket_information |> Application.get_env(:db_castore)
  end
end
