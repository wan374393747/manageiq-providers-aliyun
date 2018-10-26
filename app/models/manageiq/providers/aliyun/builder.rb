class ManageIQ::Providers::Aliyun::Builder
  class << self
    def build_inventory(ems, target)
      case target
      when InventoryRefresh::TargetCollection
        targeted_inventory(ems, target)
      else
        cloud_manager_inventory(ems, target)
      end
    end

    private

    def cloud_manager_inventory(ems, target)
      collector_klass = ManageIQ::Providers::Aliyun::Inventory::Collector::CloudManager
      persister_klass = ManageIQ::Providers::Aliyun::Inventory::Persister::CloudManager
      parser_klass    = ManageIQ::Providers::Aliyun::Inventory::Parser::CloudManager

      inventory(ems, target, collector_klass, persister_klass, [parser_klass])
    end

    def targeted_inventory(ems, target)
      collector_klass = ManageIQ::Providers::Aliyun::Inventory::Collector::TargetCollection
      persister_klass = ManageIQ::Providers::Aliyun::Inventory::Persister::TargetCollection
      parser_klass    = ManageIQ::Providers::Aliyun::Inventory::Parser::CloudManager

      inventory(ems, target, collector_klass, persister_klass, [parser_klass])
    end

    def inventory(manager, raw_target, collector_class, persister_class, parser_classes)
      collector = collector_class.new(manager, raw_target)
      persister = persister_class.new(manager, raw_target)

      ::ManageIQ::Providers::Aliyun::Inventory.new(persister, collector, parser_classes.map(&:new))
    end
  end
end
