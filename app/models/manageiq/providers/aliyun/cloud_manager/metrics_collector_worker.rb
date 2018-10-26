class ManageIQ::Providers::Aliyun::CloudManager::MetricsCollectorWorker < ManageIQ::Providers::BaseManager::MetricsCollectorWorker
  require_nested :Runner

  self.default_queue_name = "Aliyun"

  def friendly_name
    @friendly_name ||= "C&U Metrics Collector for Aliyun"
  end
end
