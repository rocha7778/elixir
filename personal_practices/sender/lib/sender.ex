defmodule Sender do
  @moduledoc """
  Documentation for `Sender`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Sender.hello()
      :world

  """
  def hello do
    :world
  end

  def send_email("konnichiwa@world.com" = email) do
    raise "Oops, couldn't send email to #{email}!"
   end

  def send_email("rocha@world.com" = email) do
    :error
   end

  def send_email(email) do
    Process.sleep(3000)
    IO.puts("Email to #{email} sent")
    {:ok, :email_send}
  end

  def notify_all(emails) do
    Enum.each(emails, fn email -> send_email(email) end)
  end

  def notify_all_async(emails) do
    Enum.each(
      emails,
      fn email -> Task.start(fn -> send_email(email) end) end
    )
    {:ok, :all_emails_was_sent}
  end

  def notify_all_async_and_await(emails) do

    emails
    |> Enum.map(
      fn email -> Task.async(fn -> send_email(email) end) end
    )|> Enum.map(fn task-> Task.await(task) end)
    {:ok, :all_emails_was_sent}
  end

  def notify_all_stream(emails) do
    emails
     |> Task.async_stream(fn email -> send_email(email) end, ordered: false, max_concurrency: 50)
     |> Enum.to_list()
    {:ok, :all_emails_was_sent}
  end

  def notify_all_not_link(emails) do

     Sender.EmailTaskSupervisor
     |> Task.Supervisor.async_stream_nolink(emails, fn email -> send_email(email) end)
     |> Enum.to_list()
    {:ok, :all_emails_was_sent}
  end

  def generate_emails do
    Enum.map(1..100_000, fn _ -> Faker.Internet.email() end)
  end

end

# {micro_seconds, response} = :timer.tc(Sender, :notify_all_async, [Sender.generate_emails()])
# IO.puts("Tiempo de respuesta de la api  #{(micro_seconds/1_000_000)} sg")
# Sender.notify_all_async_and_await( Sender.generate_emails())
# Sender.notify_all_stream( Sender.generate_emails())
# Sender.notify_all_stream(emails)
# Sender.notify_all_not_link(emails)
# Sender.notify_all(emails)
