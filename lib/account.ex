defmodule Account do

  defstruct user: User, balance: nil

  def create_account(user), do: %__MODULE__{user: user, balance: 1000}

  def transfer(accounts, from, to, value) do
    from = Enum.find(accounts, fn account -> account.user.email == from.user.email end)
  
    cond do
      validate_balance(from.balance, balance) -> {:error, "insufficient funds"}
      true ->
        to = Enum.find(accounts, fn account -> account.user.email == to.user.email end)
        from = %Account{from | balance: from.balance - value}
        to = %Account{to | balance: to.balance + value}
      [from, to]
    end
  end

  defp validate_balance(balance, value), do: balance < value
end