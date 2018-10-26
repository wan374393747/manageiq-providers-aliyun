module ManageIQ
  module Providers::Aliyun
    module Regions
      REGIONS = {
        "cn-qingdao"        => {
          :name        => "cn-qingdao",
          :hostname    => "ecs.aliyuncs.com",
          :description => "China (Qingdao)"
        },
        "cn-beijing"        => {
          :name        => "cn-beijing",
          :hostname    => "ecs.aliyuncs.com",
          :description => "China (Beijing)"
        },
        "cn-zhangjiakou"    => {
          :name        => "cn-zhangjiakou",
          :hostname    => "ecs.cn-zhangjiakou.aliyuncs.com",
          :description => "China (Zhangjiakou)"
        },
        "cn-huhehaote"      => {
          :name        => "cn-huhehaote",
          :hostname    => "ecs.cn-huhehaote.aliyuncs.com",
          :description => "China (Hohhot)"
        },
        "cn-hangzhou"       => {
          :name        => "cn-hangzhou",
          :hostname    => "ecs.aliyuncs.com",
          :description => "China (Hangzhou)"
        },
        "cn-shanghai"       => {
          :name        => "cn-shanghai",
          :hostname    => "ecs.aliyuncs.com",
          :description => "China (Shanghai)"
        },
        "cn-shenzhen"       => {
          :name        => "cn-shenzhen",
          :hostname    => "ecs.aliyuncs.com",
          :description => "China (Shenzhen)"
        }
      }

      def self.regions
        additional_regions = Hash(Settings.ems.ems_aliyun.try!(:additional_regions)).stringify_keys
        disabled_regions   = Array(Settings.ems.ems_aliyun.try!(:disabled_regions))

        REGIONS.merge(additional_regions).except(*disabled_regions)
      end

      def self.regions_by_hostname
        regions.values.index_by { |v| v[:hostname] }
      end

      def self.all
        regions.values
      end

      def self.names
        regions.keys
      end

      def self.hostnames
        regions_by_hostname.keys
      end

      def self.find_by_name(name)
        regions[name]
      end

      def self.find_by_hostname(hostname)
        regions_by_hostname[hostname]
      end
    end
  end
end
