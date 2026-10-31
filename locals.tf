locals {
  tags = {
    Project        = "CCGC 5502 Terraform Project"
    Name           = "Germain.Tegomo"
    ExpirationDate = "2027-12-31"
    Environment    = "Learning"
  }
}

locals {
  linux_vms = {
    linux-vm-1 = {
      zone = "1"
    }

    linux-vm-2 = {
      zone = "2"
    }

    linux-vm-3 = {
      zone = "3"
    }
  }
}

locals {
  ScheduledScanSettings = {
    isEnabled = "false"
    day       = "7"
    time      = "120"
    scanType  = "Quick"
  }
}

