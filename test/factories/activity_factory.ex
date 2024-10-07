defmodule DesafioFullstack.ActivityFactory do
  @moduledoc false

  alias DesafioFullstack.Activities.Activity
  alias Faker.{Address, Internet, Phone, Lorem, Commerce, Color}

  defmacro __using__(_opts) do
    quote do
      def activity_factory do
        %Activity{
          title: "{Commerce.department()} {Color.fancy_name}",
          photo: "https://picsum.photos/200/300",
          description: String.slice(Lorem.paragraph(), 0..254),
          instagram_account: "@" + Commerce.department(),
          google_place: "",
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
  end
end
