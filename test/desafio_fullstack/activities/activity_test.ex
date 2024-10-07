defmodule DesafioFullstack.Activities.ActivityTest do

  use(DesafioFullstack.DataCase, async: true)

  import DesafioFullstack.Factory

  alias DesafioFullstack.Activities.Activity

  describe "changeset/2" do
    test "valid changeset" do
      activity = params_for(:activity)

      changeset = Activity.changeset(%Activity{}, activity)

      assert changeset.errors == []
      assert changeset.valid?

      assert Enum.count(changeset.changes) == 5
    end

    test "invalid changeset" do
      changeset = Activity.changeset(%Activity{}, %{})

      refute changeset.valid?

      assert errors_on(changeset).title == ["can't be blank"]
      assert errors_on(changeset).photo == ["can't be blank"]
      assert errors_on(changeset).description == ["can't be blank"]
      assert errors_on(changeset).google_place == ["can't be blank"]
      assert errors_on(changeset).address == ["can't be blank"]
      assert errors_on(changeset).tags == ["can't be blank"]
    end
  end

end
