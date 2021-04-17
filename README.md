# githubConsultationModule
PowerShell module for in-depth research and consultation of GitHub.

## Contents

1. [Manually install the cloned module on your system](#manually_install_the_cloned_module_on_your_system)

<a name="manually_install_the_cloned_module_on_your_system"></a>
### Manually install the cloned module on your system

You can install this Powershell module on your windows system, so that you will just need to import this module with the command bellow when opening Powershell :

```powershell
Import-Module githubConsultationModule
```
Let's see how to do this.

Firstable, you must execute this following command in Powershell :

```powershell
$ENV:PSModulePath
```
It will display you all install paths for Powershell modules.

Secondly, you must move the Powershell module to one of the directory displayed by the previous command.
About the first step command there will be 2 main paths in results :

- C:\Users\<User Name>\Documents\WindowsPowerShell\modules
- C:\program files\WindowsPowerShell\Modules\<Module Folder>\<Module Files>
	
If you want the module to be available for a specific user, move the Powershell module to the directory indicated by the first path.
Or if you want the module to be available for all users, move the Powershell module to the directory indicated by the second path.

That's all. 
Now is the time for you to have some fun...
