class ManageIQ::Providers::Aliyun::CloudManager < ManageIQ::Providers::CloudManager
  require_nested :AvailabilityZone
  require_nested :Flavor
  require_nested :MetricsCapture
  require_nested :MetricsCollectorWorker
  require_nested :RefreshParser
  require_nested :RefreshWorker
  require_nested :Refresher
  require_nested :Vm

  supports :regions

  include ManageIQ::Providers::Aliyun::ManagerMixin

  def self.hostname_required?
    # TODO: ExtManagementSystem is validating this
    false
  end

  def self.ems_type
    @ems_type ||= "aliyun".freeze
  end

  def self.description
    @description ||= "Aliyun".freeze
  end

  def supported_auth_types
    %w(default smartstate_docker)
  end

  def supports_authentication?(authtype)
    supported_auth_types.include?(authtype.to_s)
  end

  def supported_catalog_types
    %w(aliyun).freeze
  end

end
