`aws ec2 describe-images --image-ids ami-04fb7beeed4da358b`

```json
{
  "Images": [
    {
      "Architecture": "x86_64",
      "CreationDate": "2023-10-16T22:27:24.000Z",
      "ImageId": "ami-04fb7beeed4da358b",
      "ImageLocation": "amazon/al2023-ami-2023.2.20231016.0-kernel-6.1-x86_64",
      "ImageType": "machine",
      "Public": true,
      "OwnerId": "137112412989",
      "PlatformDetails": "Linux/UNIX",
      "UsageOperation": "RunInstances",
      "State": "available",
      "BlockDeviceMappings": [
        {
          "DeviceName": "/dev/xvda",
          "Ebs": {
            "DeleteOnTermination": true,
            "Iops": 3000,
            "SnapshotId": "snap-09bb7c1bb478033be",
            "VolumeSize": 8,
            "VolumeType": "gp3",
            "Throughput": 125,
            "Encrypted": false
          }
        }
      ],
      "Description": "Amazon Linux 2023 AMI 2023.2.20231016.0 x86_64 HVM kernel-6.1",
      "EnaSupport": true,
      "Hypervisor": "xen",
      "ImageOwnerAlias": "amazon",
      "Name": "al2023-ami-2023.2.20231016.0-kernel-6.1-x86_64",
      "RootDeviceName": "/dev/xvda",
      "RootDeviceType": "ebs",
      "SriovNetSupport": "simple",
      "VirtualizationType": "hvm",
      "BootMode": "uefi-preferred",
      "DeprecationTime": "2024-01-14T22:27:00.000Z",
      "ImdsSupport": "v2.0"
    }
  ]
}
```
