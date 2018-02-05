defmodule SmartAc.DevicesTest do
  use SmartAc.DataCase

  alias SmartAc.Devices

  describe "air_conditioners" do
    alias SmartAc.Devices.AirConditioner

    @valid_attrs %{firmware_version: "some firmware_version", registered_at: "2010-04-17 14:00:00.000000Z", serial: "some serial"}
    @update_attrs %{firmware_version: "some updated firmware_version", registered_at: "2011-05-18 15:01:01.000000Z", serial: "some updated serial"}
    @invalid_attrs %{firmware_version: nil, registered_at: nil, serial: nil}

    def air_conditioner_fixture(attrs \\ %{}) do
      {:ok, air_conditioner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Devices.create_air_conditioner()

      air_conditioner
    end

    test "list_air_conditioners/0 returns all air_conditioners" do
      air_conditioner = air_conditioner_fixture()
      assert Devices.list_air_conditioners() == [air_conditioner]
    end

    test "get_air_conditioner!/1 returns the air_conditioner with given id" do
      air_conditioner = air_conditioner_fixture()
      assert Devices.get_air_conditioner!(air_conditioner.id) == air_conditioner
    end

    test "find_air_conditioner_by_serial/1 returns the air_conditioner with given serial" do
      air_conditioner = air_conditioner_fixture()

      assert Devices.find_air_conditioner_by_serial(air_conditioner.serial) == air_conditioner
    end

    test "create_air_conditioner/1 with valid data creates a air_conditioner" do
      assert {:ok, %AirConditioner{} = air_conditioner} = Devices.create_air_conditioner(@valid_attrs)
      assert air_conditioner.firmware_version == "some firmware_version"
      assert air_conditioner.registered_at == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert air_conditioner.serial == "some serial"
    end

    test "create_air_conditioner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_air_conditioner(@invalid_attrs)
    end

    test "create_air_conditioner/1 with already existing serial returns error changeset" do
      air_conditioner = air_conditioner_fixture()
      matching_serial_attrs = Map.merge(@valid_attrs, %{serial: air_conditioner.serial})

      assert {:error, %Ecto.Changeset{}} = Devices.create_air_conditioner(matching_serial_attrs)
    end

    test "update_air_conditioner/2 with valid data updates the air_conditioner" do
      air_conditioner = air_conditioner_fixture()
      assert {:ok, air_conditioner} = Devices.update_air_conditioner(air_conditioner, @update_attrs)
      assert %AirConditioner{} = air_conditioner
      assert air_conditioner.firmware_version == "some updated firmware_version"
      assert air_conditioner.registered_at == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert air_conditioner.serial == "some updated serial"
    end

    test "update_air_conditioner/2 with invalid data returns error changeset" do
      air_conditioner = air_conditioner_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_air_conditioner(air_conditioner, @invalid_attrs)
      assert air_conditioner == Devices.get_air_conditioner!(air_conditioner.id)
    end

    test "delete_air_conditioner/1 deletes the air_conditioner" do
      air_conditioner = air_conditioner_fixture()
      assert {:ok, %AirConditioner{}} = Devices.delete_air_conditioner(air_conditioner)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_air_conditioner!(air_conditioner.id) end
    end

    test "change_air_conditioner/1 returns a air_conditioner changeset" do
      air_conditioner = air_conditioner_fixture()
      assert %Ecto.Changeset{} = Devices.change_air_conditioner(air_conditioner)
    end
  end
end
