defmodule PocketInformation.Test.Support.TestStubsNullRemover do
  def pocket_with_null_values do
    %{
      data: [
        %{
          account: %PocketInformation.Domain.Model.Account.Account{
            number: "91200244139",
            pocket: %PocketInformation.Domain.Model.Pocket.Pocket{
              balance: 0,
              closedDate: nil,
              name: "BOLSILLO MUESTRA",
              number: "912002441392",
              openDate: "2019-06-25",
              savingsGoal: nil,
              state: "CANCELADO",
              category: %PocketInformation.Domain.Model.Pocket.Category{
                id: "0001",
                reference: "stethoscope"
              },
              dates: %PocketInformation.Domain.Model.Pocket.SavingDates{
                savingsEndDate: nil,
                savingsStartDate: "2019-06-25"
              },
              scheduledTransfer: %PocketInformation.Domain.Model.Pocket.ScheduledTransfer{
                amount: 0,
                day: 0,
                endDate: nil,
                frequency: nil,
                startDate: nil
              }
            },
            type: "CUENTA_DE_AHORRO"
          }
        }
      ]
    }
  end
  def pocket_with_savings_end_date_values do
    %{
      data: [
        %{
          account: %PocketInformation.Domain.Model.Account.Account{
            number: "91200244139",
            pocket: %PocketInformation.Domain.Model.Pocket.Pocket{
              balance: 0,
              closedDate: nil,
              name: "BOLSILLO MUESTRA",
              number: "912002441392",
              openDate: "2019-06-25",
              savingsGoal: 0,
              state: "CANCELADO",
              category: %PocketInformation.Domain.Model.Pocket.Category{
                id: "0001",
                reference: "stethoscope"
              },
              dates: %PocketInformation.Domain.Model.Pocket.SavingDates{
                savingsEndDate: "2023-06-25",
                savingsStartDate: "2019-06-25"
              },
              scheduledTransfer: %PocketInformation.Domain.Model.Pocket.ScheduledTransfer{
                amount: 0,
                day: 0,
                endDate: nil,
                frequency: nil,
                startDate: nil
              }
            },
            type: "CUENTA_DE_AHORRO"
          }
        }
      ]
    }
  end
  def pocket_with_close_date_values do
    %{
      data: [
        %{
          account: %PocketInformation.Domain.Model.Account.Account{
            number: "91200244139",
            pocket: %PocketInformation.Domain.Model.Pocket.Pocket{
              balance: 0,
              closedDate: "2023-06-25",
              name: "BOLSILLO MUESTRA",
              number: "912002441392",
              openDate: "2019-06-25",
              savingsGoal: 0,
              state: "CANCELADO",
              category: %PocketInformation.Domain.Model.Pocket.Category{
                id: "0001",
                reference: "stethoscope"
              },
              dates: %PocketInformation.Domain.Model.Pocket.SavingDates{
                savingsEndDate: "2023-06-25",
                savingsStartDate: "2019-06-25"
              },
              scheduledTransfer: %PocketInformation.Domain.Model.Pocket.ScheduledTransfer{
                amount: 0,
                day: 0,
                endDate: nil,
                frequency: nil,
                startDate: nil
              }
            },
            type: "CUENTA_DE_AHORRO"
          }
        }
      ]
    }
  end
  def pocket_with_frequency_values do
    %{
      data: [
        %{
          account: %PocketInformation.Domain.Model.Account.Account{
            number: "91200244139",
            pocket: %PocketInformation.Domain.Model.Pocket.Pocket{
              balance: 0,
              closedDate: "2023-06-25",
              name: "BOLSILLO MUESTRA",
              number: "912002441392",
              openDate: "2019-06-25",
              savingsGoal: 0,
              state: "CANCELADO",
              category: %PocketInformation.Domain.Model.Pocket.Category{
                id: "0001",
                reference: "stethoscope"
              },
              dates: %PocketInformation.Domain.Model.Pocket.SavingDates{
                savingsEndDate: "2023-06-25",
                savingsStartDate: "2019-06-25"
              },
              scheduledTransfer: %PocketInformation.Domain.Model.Pocket.ScheduledTransfer{
                amount: 0,
                day: 0,
                endDate: nil,
                frequency: "SEMANAL",
                startDate: nil
              }
            },
            type: "CUENTA_DE_AHORRO"
          }
        }
      ]
    }
  end
  def pocket_with_startDate_values do
    %{
      data: [
        %{
          account: %PocketInformation.Domain.Model.Account.Account{
            number: "91200244139",
            pocket: %PocketInformation.Domain.Model.Pocket.Pocket{
              balance: 0,
              closedDate: "2023-06-25",
              name: "BOLSILLO MUESTRA",
              number: "912002441392",
              openDate: "2019-06-25",
              savingsGoal: 0,
              state: "CANCELADO",
              category: %PocketInformation.Domain.Model.Pocket.Category{
                id: "0001",
                reference: "stethoscope"
              },
              dates: %PocketInformation.Domain.Model.Pocket.SavingDates{
                savingsEndDate: "2023-06-25",
                savingsStartDate: "2019-06-25"
              },
              scheduledTransfer: %PocketInformation.Domain.Model.Pocket.ScheduledTransfer{
                amount: 0,
                day: 0,
                endDate: nil,
                frequency: "SEMANAL",
                startDate: "2022-07-28"
              }
            },
            type: "CUENTA_DE_AHORRO"
          }
        }
      ]
    }
  end
  def pocket_with_end_date_values do
    %{
      data: [
        %{
          account: %PocketInformation.Domain.Model.Account.Account{
            number: "91200244139",
            pocket: %PocketInformation.Domain.Model.Pocket.Pocket{
              balance: 0,
              closedDate: "2023-06-25",
              name: "BOLSILLO MUESTRA",
              number: "912002441392",
              openDate: "2019-06-25",
              savingsGoal: 0,
              state: "CANCELADO",
              category: %PocketInformation.Domain.Model.Pocket.Category{
                id: "0001",
                reference: "stethoscope"
              },
              dates: %PocketInformation.Domain.Model.Pocket.SavingDates{
                savingsEndDate: "2023-06-25",
                savingsStartDate: "2019-06-25"
              },
              scheduledTransfer: %PocketInformation.Domain.Model.Pocket.ScheduledTransfer{
                amount: 0,
                day: 0,
                endDate: "2024-07-28",
                frequency: "SEMANAL",
                startDate: "2022-07-28"
              }
            },
            type: "CUENTA_DE_AHORRO"
          }
        }
      ]
    }
  end
end
