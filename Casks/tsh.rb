cask "tsh" do
  module Utils
    def self.version
      return "17.2.8"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://cdn.teleport.dev/tsh-#{version}.pkg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://cdn.teleport.dev/tsh-#{version}.pkg",
      verified: "cdn.teleport.dev"
  name "tsh"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. TSH client only"
  homepage "https://goteleport.com/"
  pkg "tsh-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport.tsh"
  ]

  caveats do
    license "AGPL-3.0"
  end
end
