# posh-direnv

Inspired by [direnv](https://github.com/direnv/direnv), posh-direnv is an environment switcher that executes PowerShell commands in a `.psenvrc` file when entering a directory. Using posh-direnv users can easily set environment variables or run setup code without having to remember to do so manually. posh-direnv is designed to be lightweight and easy to use, with no dependencies other than PowerShell itself.

## Installation
Clone the repository and install posh-direnv with the following command:

```powershell
> ./Install.ps1
```


This will install the module in the `PSModulePath`  and update the current PowerShell profile (if necessary) to import the module on startup.


## Usage

Create or navigate to a directory and create a `.psenvrc` file using the following command:

```powershell
> mkdir work # optional
> cd work
> Edit-DirEnvRc
```

This will open a `.psenvrc` file in the current directory using the notepad editor. Once the file is modified and saved, the file will be executed. Note that you can also edit the file manually (see below).

For example, suppose that you entered the following code into the `.psenvrc` file:

```powershell
> cat .\.psenvrc
Write-Host "Hello posh-direnv"
$Host.UI.RawUI.WindowTitle="posh-direnv"
```

Upon navigating to the `.\work` directory (in a new PowerShell instance), the `.psenvrc` file will be executed and the environment changes will be applied.

```powershell
> cd work
psenvdir: loading work/.psenvrc
Hello posh-direnv
psenvdir: export
```

Once you exit the directory tree the environment changes will be reversed.

```powershell
> cd ..
psenvdir: unloading
```

If you edit the .psenvrc file yourself or move it between directories you must authorize it before it will be applied.

```powershell
> cd work
psenvdir: work/.psenvrc not in allow list

> Approve-DirEnvRc
psenvdir: loading work/.psenvrc
Hello posh-direnv
psenvdir: export
```

You can unauthorize a `.psenvrc` file by calling `Deny-DirEnvRc` and cleanup the authorized list in the event directories are deleted before being denied by calling `Repair-DirEnvAuth`.


### Development

Use the following command to temporarily install the module in the current shell:

```powershell
> .\InstallDev.ps1
```