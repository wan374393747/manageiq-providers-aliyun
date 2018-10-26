class ManageIQ::Providers::Aliyun::CloudManager::Refresher < ManageIQ::Providers::BaseManager::ManagerRefresher
  def parse_legacy_inventory(ems)
    ManageIQ::Providers::Aliyun::CloudManager::RefreshParser.ems_inv_to_hashes(ems, refresher_options)
  end

  def save_inventory(ems, target, _hashes_or_persister)
    super

    EmsRefresh.queue_refresh(ems.network_manager) if target.kind_of?(ManageIQ::Providers::BaseManager)
    # EmsRefresh.queue_refresh(ems.ebs_storage_manager) if target.kind_of?(ManageIQ::Providers::BaseManager)
  end

  # List classes that will have post process method invoked
  def post_process_refresh_classes
    [::Vm]
  end
end
