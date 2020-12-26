# Definition of the File Powershell class to define a file in a repository from the GitHub API...
class File
{
    # All attributes of the File class...
    hidden [string]$sha
    hidden [string]$filename
    hidden [string]$status

    hidden [int]$additions
    hidden [int]$deletions
    hidden [int]$changes

    hidden [string]$blob
    hidden [string]$raws
    hidden [string]$contents
    hidden [string]$patch

    # File class constructor with user login, repository name and file's name... 
    File([string]$wishedUserLogin, [string]$wishedRepositoryName, [string]$wishedFileName)
    {
        # Extract all the data relating to the desired file identified by the desired user login, the desired repository name and desired file's name...
        $githubGetFileURL = "https://api.github.com/repos/" + $wishedUserLogin + "/" + $wishedRepositoryName + "/contents/" + $wishedFileName
    }

    # File class constructor with all required parameters...
    File([string]$sha, [string]$filename, [string]$status, [int]$additions, [int]$deletions, [int]$changes, [string]$blob, [string]$raws, [string]$contents, [string]$patch)
    {
        $this.sha = $sha
        $this.filename = $filename
        $this.status = $status

        $this.additions = $additions
        $this.deletions = $deletions
        $this.changes = $changes

        $this.blob = $blob
        $this.raws = $raws
        $this.contents = $contents
        $this.patch = $patch
    }
}