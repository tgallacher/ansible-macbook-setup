# VM Setup

Detials on the VM setup for testing changes.

## SSH Access

Need to enable port forwarding. This can be done from the VM settings page: `Network` > `Port forwarding` and then enter a new entry.

The Ansible set up currently assumes the host port is `2222`. See `inventory-vm`.

## Notes

Configure VM (one time run, when creating the VM). Isn't required after a VirtualBox image has been created.

```sh
VBoxManage modifyvm "<vm_name>" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage setextradata "<vm_name>" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac19,1"
VBoxManage setextradata "<vm_name>" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "<vm_name>" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-AA95B1DDAB278B95"
VBoxManage setextradata "<vm_name>" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "<vm_name>" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
# Fix OSX Monterey kernal panic
# see https://apple.stackexchange.com/a/437357
VBoxManage setextradata "<vm_name>" "VBoxInternal/TM/TSCMode" "RealTSCOffset"
```
