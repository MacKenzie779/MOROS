# Welcome to

```ocaml
 _ __ ___   ___  _ __ ___  ___
| '_ ` _ \ / _ \| '__/ _ \/ __|
| | | | | | (_) | | | (_) \__ \
|_| |_| |_|\___/|_|  \___/|___/
```

Just another ArchLinux Setup Script

## During installation you can choose between following partition schemes:

### 1. Laptop Dualboot

| Mount point | Size                   | Filesystem |
| ----------- | ---------------------- | ---------- |
| /boot       | 1 GiB (for dualboot)   | FAT32      |
| SWAP        | 32 GiB (2 x RAM)       | SWAP       |
| /           | 1/3 of free disk space | EXT4       |
| /home       | 2/3 of free disk space | EXT4       |

### 2. Desktop Singleboot

| Mount point | Size                   | Filesystem |
| ----------- | ---------------------- | ---------- |
| /boot       | 1 GiB (for dualboot)   | FAT32      |
| SWAP        | 32 GiB (2 x RAM)       | SWAP       |
| /           | 1/3 of free disk space | EXT4       |
| /home       | 2/3 of free disk space | EXT4       |

### 3. VM (for Virtual Machines)

| Mount point | Size                    | Filesystem |
| ----------- | ----------------------- | ---------- |
| /boot       | 512 MiB                 | FAT32      |
| /           | 100% of free disk space | EXT4       |