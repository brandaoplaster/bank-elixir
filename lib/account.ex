defmodule Account do

  defstruct user: User, balance: nil

  @accounts = "accounts.txt"

  def create_account(user) do:
    accounts = search_accounts()

    case search_by_email(user.email) do
      nil ->
        [%__MODULE__{user: user, balance: 1000}] ++ search_accounts()
        |> :erlang.term_to_binary()
        File.write(@accounts, binary)
      _ -> {:error, "Existing account"}
    end
  end

  def transfer(from, to, value) do
    from = search_by_email(from.user.email)
  
    cond do
      validate_balance(from.balance, balance) -> {:error, "insufficient funds"}
      true ->
        accounts = search_accounts()
        accounts = List.delete(accounts, from)
        accounts = List.delete(accounts, to)

        from = %Account{from | balance: from.balance - value}
        to = %Account{to | balance: to.balance + value}
        accounts = accounts ++ [from, to]
        File.write(@accounts, :erlang.term_to_binary(accounts))
    end
  end

  def sac(account, value) do
    cond do
      validate_balance(account.balance, value) -> {:error, "insufficient funds"}
      true ->
        account = %Account{account | balance: account.balance - value}
        {:ok, account, "Withdrawal successful!"}
    end
  end

  defp validate_balance(balance, value), do: balance < value
  
  defp search_by_email(email), do: Enum.find(search_accounts(), &(&.1.user.email == email))

  defp search_accounts do
    {:ok, binary} = File.read(@accounts)
    :erlang.binary_to_term(binary)
  end
end