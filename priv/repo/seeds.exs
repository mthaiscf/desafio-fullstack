# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DesafioFullstack.Repo.insert!(%DesafioFullstack.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule DesafioFullstack.Seeds do

  alias Faker.{Address, Internet, Phone, Lorem, Commerce, Color}
  alias DesafioFullstack.Activities

  def run(:dev) do
    number_of_activities_to_generate = 100
    generate_activities(number_of_activities_to_generate)
  end

  defp generate_activities(number_of_activities_to_generate) do
    for _n <- 0..(number_of_activities_to_generate - 1) do
      activity = activity_params()

      {:ok, _activity} = Activities.create_activity(activity)
    end
  end

  defp activity_params() do
    %{
      title: "#{Commerce.department()} #{Color.fancy_name}",
      photo: "https://picsum.photos/200/300",
      description: String.slice(Lorem.paragraph(), 0..254),
      instagram_account: "@#{Commerce.department()}",
      google_place: Internet.url(),
      url: Internet.url(),
      address: Address.PtBr.street_address(),
      address_complement: "-",
      email: Internet.email(),
      phone_number: Phone.PtBr.phone(),
      city: "Maceió",
      tags: %{tags: ["gratuito"]}
    }
  end

end

DesafioFullstack.Seeds.run(Mix.env())
