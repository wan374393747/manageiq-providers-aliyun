class ManageIQ::Providers::Aliyun::Inventory::Collector::TargetCollection < ManageIQ::Providers::DummyProvider::Inventory::Collector
  def flavors
    []
  end

  def vms
    [
      {
        "name"          => "vm1",
        "uuid"          => "543b7632-75c9-41c8-b507-5d78404b22f4",
        "instance_type" => "micro",
      },
    ]
  end
end
