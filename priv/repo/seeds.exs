# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SpacexMissionApi.Repo.insert!(%SpacexMissionApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.


alias SpacexMissionApi.Booster
alias SpacexMissionApi.Vehicle
alias SpacexMissionApi.Repo
alias SpacexMissionApi.Mission
alias SpacexMissionApi.LandingZone
alias SpacexMissionApi.FalconNineBuilder

Repo.delete_all Mission
Repo.delete_all Vehicle
Repo.delete_all Booster
Repo.delete_all LandingZone

defmodule BoosterMocker do
  def create_booster(core_number, version, status) do
    b = Booster.changeset(%Booster{},%{
      core_number: core_number,
      version: version,
      status: status
    })
    Repo.insert(b)
  end
end

defmodule MissionMocker do
  def mock_mission(core_number, landing_zone, launch_site, name) do
    vehicle = FalconNineBuilder.start
    |> FalconNineBuilder.attach_core(core_number)
    |> FalconNineBuilder.with_name("falcon 9")
    |> FalconNineBuilder.build

    if landing_zone != nil do
      lz = Repo.get_by(LandingZone, name: landing_zone)
      lz_id = lz.id
    else
      lz_id = nil
    end


    cs = Mission.changeset(%Mission{
      vehicle_id: vehicle.id,
      landing_zone_id: lz_id,
      name: name
    })
    Repo.insert(cs)
  end
end


Repo.insert! %LandingZone{
  name: "ocean"
}

Repo.insert! %LandingZone{
  name: "jrti"
}

Repo.insert! %LandingZone{
  name: "ocisly"
}

Repo.insert! %LandingZone{
  name: "lz-1"
}

BoosterMocker.create_booster("B0003", "1.0", "expended")
BoosterMocker.create_booster("B0004", "1.0", "expended")
BoosterMocker.create_booster("B0005", "1.0", "expended")
BoosterMocker.create_booster("B0006", "1.0", "expended")
BoosterMocker.create_booster("B0007", "1.0", "expended")
BoosterMocker.create_booster("B1003", "1.1", "destroyed")
BoosterMocker.create_booster("B1004*", "1.1", "expended")
BoosterMocker.create_booster("B1005*", "1.1", "expended")
BoosterMocker.create_booster("B1006*", "1.1", "obsolete")
BoosterMocker.create_booster("B1007*", "1.1", "obsolete")
BoosterMocker.create_booster("B1008*", "1.1", "expended")
BoosterMocker.create_booster("B1011", "1.1", "expended")
BoosterMocker.create_booster("B1010", "1.1", "retired")
BoosterMocker.create_booster("B1012", "1.1", "destroyed")
BoosterMocker.create_booster("B1013", "1.1", "obsolete")
BoosterMocker.create_booster("B1014", "1.1", "expended")
BoosterMocker.create_booster("B1015", "1.1", "destroyed")
BoosterMocker.create_booster("B1016", "1.1", "expended")
BoosterMocker.create_booster("B1018", "1.1", "destroyed")
BoosterMocker.create_booster("B1019", "FT", "displayed")
BoosterMocker.create_booster("B1017", "1.1", "destroyed")
BoosterMocker.create_booster("B1020", "FT", "destroyed")
BoosterMocker.create_booster("B1021.1", "FT", "displayed")
BoosterMocker.create_booster("B1022", "FT", "obsolete")
BoosterMocker.create_booster("B1023.1", "FT", "waiting for falcon heavy")
BoosterMocker.create_booster("B1024", "FT", "destroyed")
BoosterMocker.create_booster("B1025", "FT", "waiting for falcon heavy")
BoosterMocker.create_booster("B1026", "FT", "storage")
BoosterMocker.create_booster("B1028", "FT", "destroyed")
BoosterMocker.create_booster("B1029.1", "FT", "reused")
BoosterMocker.create_booster("B1031.1", "FT", "storage")
BoosterMocker.create_booster("B1030", "FT", "expended")
BoosterMocker.create_booster("B1021.2", "FT", "displayed - reused")
BoosterMocker.create_booster("B1032.1", "FT", "storage")
BoosterMocker.create_booster("B1034", "FT", "expended")
BoosterMocker.create_booster("B1035.1", "FT", "storage")
BoosterMocker.create_booster("B1029.2", "FT", "storage")
BoosterMocker.create_booster("B1036.1", "FT", "storage")
BoosterMocker.create_booster("B1037", "FT", "expended")
BoosterMocker.create_booster("B1039.1", "FT", "storage")
BoosterMocker.create_booster("B1038.1", "FT", "storage")
BoosterMocker.create_booster("B1040.1", "FT", "storage")

MissionMocker.mock_mission("B0003", nil, "SLC-40", "Dragon Spacecraft Qualification Unit")
MissionMocker.mock_mission("B0004", nil, "SLC-40", "Dragon Demo flight Cots 1")
MissionMocker.mock_mission("B0005", nil, "SLC-40", "Dragon Demo flight Cots 2")
MissionMocker.mock_mission("B0006", nil, "SLC-40", "CRS-1")
MissionMocker.mock_mission("B0007", "ocean", "SLC-40", "CRS-2")
MissionMocker.mock_mission("B1003", "ocean", "SLC-4E", "CASSIOPE")
MissionMocker.mock_mission("B1004*", nil, "SLC-40", "SES-8")
MissionMocker.mock_mission("B1005*", nil, "SLC-40", "Thaicom 6")
MissionMocker.mock_mission("B1006*", "ocean", "SLC-40", "CRS-3")
MissionMocker.mock_mission("B1007*", "ocean", "SLC-40", "OG2")
MissionMocker.mock_mission("B1008*", nil, "SLC-40", "AsiaSat 8")
MissionMocker.mock_mission("B1011", nil, "SLC-40", "AsiaSat 6")
MissionMocker.mock_mission("B1010", "ocean", "SLC-40", "CRS-4")
MissionMocker.mock_mission("B1012", "jrti", "SLC-40", "CRS-5")
MissionMocker.mock_mission("B1013", "ocean", "SLC-40", "DSCOVR")
MissionMocker.mock_mission("B1014", nil, "SLC-40", "ABS-3A")
MissionMocker.mock_mission("B1015", "jrti", "SLC-40", "CRS-6")
MissionMocker.mock_mission("B1016", nil, "SLC-40", "TürkmenÄlem")
MissionMocker.mock_mission("B1018", nil, "SLC-40", "CRS-7")
MissionMocker.mock_mission("B1019", "lz-1", "SLC-40", "OG2-2")
MissionMocker.mock_mission("B1017", "jrti", "SLC-40", "Jason-3")
MissionMocker.mock_mission("B1020", "ocisly", "SLC-40", "SES-9")
MissionMocker.mock_mission("B1021.1", "ocisly", "SLC-40", "CRS-8")
MissionMocker.mock_mission("B1022", "ocisly", "SLC-40", "JCSAT-14")
MissionMocker.mock_mission("B1023.1", "ocisly", "SLC-40", "Thaicom 8")
MissionMocker.mock_mission("B1024", "ocisly", "SLC-40", "ABS-2A")
MissionMocker.mock_mission("B1025", "lz-1", "SLC-40", "CRS-9")
MissionMocker.mock_mission("B1026", "ocisly", "SLC-40", "JCSAT-16")
MissionMocker.mock_mission("B1028", nil, "SLC-40", "Amos-6")
MissionMocker.mock_mission("B1029.1", "jrti", "SLC-4E", "IridiumNEXT 1-10")
MissionMocker.mock_mission("B1031.1", "lz-1", "LC-39A", "CRS-10")
MissionMocker.mock_mission("B1030", nil, "LC-39A", "Echostar-23")
MissionMocker.mock_mission("B1021.2", "ocisly", "LC-39A", "SES-10")
MissionMocker.mock_mission("B1032.1", "lz-1", "LC-39A", "NROL-76")
MissionMocker.mock_mission("B1034", nil, "LC-39A", "Inmarsat5-F4")
MissionMocker.mock_mission("B1035.1", "lz-1", "LC-39A", "CRS-11")
MissionMocker.mock_mission("B1029.2", "ocisly", "LC-39A", "BulgariaSat-1")
MissionMocker.mock_mission("B1036.1", "jrti", "SLC-4E", "IridiumNEXT 11-20")
MissionMocker.mock_mission("B1037", nil, "LC-39A", "Intelsat-35e")
MissionMocker.mock_mission("B1039.1", "lz-1", "LC-39A", "CRS-12")
MissionMocker.mock_mission("B1038.1", "jrti", "SLC-4E", "Formosat-5")
MissionMocker.mock_mission("B1040.1", "lz-1", "LC-39A", "OTV-5")
