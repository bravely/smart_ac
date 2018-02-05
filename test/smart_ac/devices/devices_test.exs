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

  describe "status_reports" do
    alias SmartAc.Devices.StatusReport

    @valid_attrs %{carbon_monoxide_ppm: 42, device_health: "some device_health", humidity: 42, temperature: 42}
    @update_attrs %{carbon_monoxide_ppm: 43, device_health: "some updated device_health", humidity: 43, temperature: 43}
    @invalid_attrs %{carbon_monoxide_ppm: nil, device_health: nil, humidity: nil, temperature: nil}

    def status_report_fixture(attrs \\ %{}) do
      air_conditioner = air_conditioner_fixture()
      valid_attrs = Map.merge(@valid_attrs, %{air_conditioner_id: air_conditioner.id})
      {:ok, status_report} =
        attrs
        |> Enum.into(valid_attrs)
        |> Devices.create_status_report()

      status_report
    end

    test "list_status_reports/0 returns all status_reports" do
      status_report = status_report_fixture()
      assert Devices.list_status_reports() == [status_report]
    end

    test "get_status_report!/1 returns the status_report with given id" do
      status_report = status_report_fixture()
      assert Devices.get_status_report!(status_report.id) == status_report
    end

    test "create_status_report/1 with valid data creates a status_report" do
      valid_attrs = Map.merge(@valid_attrs, %{air_conditioner_id: air_conditioner_fixture().id})

      assert {:ok, %StatusReport{} = status_report} = Devices.create_status_report(valid_attrs)
      assert status_report.carbon_monoxide_ppm == 42
      assert status_report.device_health == "some device_health"
      assert status_report.humidity == 42
      assert status_report.temperature == 42
    end

    test "create_status_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_status_report(@invalid_attrs)
    end

    test "bulk_create_status_reports/1 with valid data returns a tuple" do
      ac = air_conditioner_fixture()
      params = [
        %{"carbon_monoxide_ppm" => 1, "device_health" => "first", "humidity" => 6, "temperature" => 11},
        %{"carbon_monoxide_ppm" => 2, "device_health" => "second", "humidity" => 7, "temperature" => 12}
      ]

      assert {:ok, [%{device_health: "first"}, %{device_health: "second"}]} = Devices.bulk_create_status_reports(ac, params)
    end

    test "update_status_report/2 with valid data updates the status_report" do
      status_report = status_report_fixture()
      assert {:ok, status_report} = Devices.update_status_report(status_report, @update_attrs)
      assert %StatusReport{} = status_report
      assert status_report.carbon_monoxide_ppm == 43
      assert status_report.device_health == "some updated device_health"
      assert status_report.humidity == 43
      assert status_report.temperature == 43
    end

    test "update_status_report/2 with invalid data returns error changeset" do
      status_report = status_report_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_status_report(status_report, @invalid_attrs)
      assert status_report == Devices.get_status_report!(status_report.id)
    end

    test "delete_status_report/1 deletes the status_report" do
      status_report = status_report_fixture()
      assert {:ok, %StatusReport{}} = Devices.delete_status_report(status_report)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_status_report!(status_report.id) end
    end

    test "change_status_report/1 returns a status_report changeset" do
      status_report = status_report_fixture()
      assert %Ecto.Changeset{} = Devices.change_status_report(status_report)
    end
  end
end
