# Importation of the 'GitHubError' module...
Using module .\gitHubError.psm1

# Definition of the Commit Powershell class to define a repository's commit from the GitHub API...
class Commit
{
    # All attributes of the Commit class...
    hidden [string]$sha
    hidden [string]$nodeId
    hidden [string]$message

    hidden [string]$loginAuthor
    hidden [string]$idAuthor
    hidden [string]$nameAuthor
    hidden [string]$emailAuthor
    hidden [datetime]$dateAuthor
    hidden [string]$nodeIdAuthor
    hidden [string]$avatarAuthor
    hidden [string]$profileAuthor
    hidden [string]$typeAuthor

    hidden [string]$loginCommitter
    hidden [string]$idCommitter
    hidden [string]$nameCommitter
    hidden [string]$emailCommiter
    hidden [datetime]$dateCommitter
    hidden [string]$nodeIdCommitter
    hidden [string]$avatarCommitter
    hidden [string]$profileCommitter
    hidden [string]$typeCommitter

    hidden [int]$total
    hidden [int]$additions
    hidden [int]$deletions
    hidden [System.Array]$files

    hidden [GitHubError]$error

    # Commit class constructor with owner login (User or Organization), repository name and sha...
    Commit([string]$wishedOwnerLogin, [string]$wishedRepositoryName, [string]$wishedSha)
    {
        # Extract all the data relating to the desired commit identified by the desired user login, the desired repository name and desired sha from the received JSON ...
        $githubGetCommitURL = "https://api.github.com/repos/" + $wishedOwnerLogin + "/" + $wishedRepositoryName + "/commits/" + $wishedSha

        # Bloc we wish execute to get all informations about the wished commit...
        try {

            #
            $githubCommitRequest = Invoke-WebRequest -Uri $githubGetCommitURL -Method Get
            $githubCommitRequestsContent = $githubCommitRequest.Content
            $githubCommitRequestsJSONContent = @"
               
$githubCommitRequestsContent
"@
            $githubCommitRequestsResult = ConvertFrom-Json -InputObject $githubCommitRequestsJSONContent

            $this.sha = $githubCommitRequestsResult.sha
            $this.nodeId = $githubCommitRequestsResult.nodeId
            $this.message = $githubCommitRequestsResult.message

            $this.loginAuthor = $githubCommitRequestsResult.author.login
            $this.idAuthor = $githubCommitRequestsResult.author.id
            $this.nameAuthor = $githubCommitRequestsResult.commit.author.name
            $this.emailAuthor = $githubCommitRequestsResult.commit.author.email
            $this.dateAuthor = [Datetime]::Parse($githubCommitRequestsResult.commit.author.date)
            $this.nodeIdAuthor = $githubCommitRequestsResult.author.node_id
            $this.avatarAuthor = $githubCommitRequestsResult.author.avatar_url
            $this.profileAuthor = $githubCommitRequestsResult.author.html_url
            $this.typeAuthor = $githubCommitRequestsResult.author.type

            $this.loginCommitter = $githubCommitRequestsResult.committer.login
            $this.idCommitter = $githubCommitRequestsResult.committer.id
            $this.nameCommitter = $githubCommitRequestsResult.commit.committer.name
            $this.emailCommiter = $githubCommitRequestsResult.commit.committer.email
            $this.dateCommitter = [Datetime]::Parse($githubCommitRequestsResult.commit.committer.date)
            $this.nodeIdCommitter = $githubCommitRequestsResult.committer.node_id
            $this.avatarCommitter = $githubCommitRequestsResult.committer.avatar_url
            $this.profileCommitter = $githubCommitRequestsResult.committer.html_url
            $this.typeCommitter = $githubCommitRequestsResult.committer.type

            $this.total = $githubCommitRequestsResult.stats.total
            $this.additions = $githubCommitRequestsResult.stats.additions
            $this.deletions = $githubCommitRequestsResult.stats.deletions

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $this.error = [GitHubError]::new($errorType, $errorMessage, $errorStackTrace)
        }
    }

    # Commit class constructor with all class attributes in parameter...
    Commit([string]$sha, [string]$nodeId, [string]$message, [string]$loginAuthor, [string]$idAuthor, [string]$nameAuthor, [string]$emailAuthor, [datetime]$dateAuthor,
           [string]$nodeIdAuthor, [string]$avatarAuthor, [string]$profileAuthor, [string]$typeAuthor, [string]$loginCommitter, [string]$idCommitter, [string]$nameCommitter, [string]$emailCommiter, 
           [datetime]$dateCommitter, [string]$nodeIdCommitter, [string]$avatarCommitter, [string]$profileCommitter, [string]$typeCommitter)
    {
        $this.sha = $sha
        $this.nodeId = $nodeId
        $this.message = $message
        $this.loginAuthor = $loginAuthor
        $this.idAuthor = $idAuthor
        $this.nameAuthor = $nameAuthor
        $this.emailAuthor = $emailAuthor
        $this.dateAuthor = $dateAuthor
        $this.nodeIdAuthor = $nodeIdAuthor
        $this.avatarAuthor = $avatarAuthor
        $this.profileAuthor = $profileAuthor
        $this.typeAuthor = $typeAuthor
        $this.loginCommitter = $loginCommitter
        $this.idCommitter = $idCommitter
        $this.nameCommitter = $nameCommitter
        $this.emailCommiter = $emailCommiter
        $this.dateCommitter = $dateCommitter
        $this.nodeIdCommitter = $nodeIdCommitter
        $this.avatarCommitter = $avatarCommitter
        $this.profileCommitter = $profileCommitter
        $this.typeCommitter = $typeCommitter
    }

    Commit(){}

    # Definition of a static function to put all commits from a owner (User or Organization) and a repository identified respectively by its login and its name inside an array...
    static [System.Array] listAllCommits([string]$wishedOwnerLogin, [string]$wishedRepositoryName, [bool]$withMissingDatas)
    {
        # Definition of the 'commitsArray' array which will contain all commits of the wished 'wishedRepositoryName' repo from the wished 'wishedUserLogin' user...
        $commitsArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about commits...
        try {

            # Create an HTTP request to take all commits of the GitHub repository identified by its name and its owner's login...
            $githubGetCommitsReposURL = "https://api.github.com/repos/" + $wishedOwnerLogin + "/" + $wishedRepositoryName + "/commits"

            # Retrieving and extracting all commits received from the URL...
            $githubCommitsReposRequest = Invoke-WebRequest -Uri $githubGetCommitsReposURL -Method Get
            $commitsJSONObj = ConvertFrom-Json $githubCommitsReposRequest.Content

            # Browse all the commits contained in the received JSON and create all the instances of the Powershell class 'Commit' from this data and add them to the array 'commitsArray'...
            foreach($commit in $commitsJSONObj) {

                $commitsArray.Add([Commit]::new($commit.sha,
                                                $commit.node_id,
                                                $commit.commit.message,
                                                $commit.author.login,
                                                $commit.author.id,
                                                $commit.commit.author.name,
                                                $commit.commit.author.email,
                                                [Datetime]::Parse($commit.commit.author.date),
                                                $commit.author.node_id,
                                                $commit.author.avatar_url,
                                                $commit.author.html_url,
                                                $commit.author.type,
                                                $commit.committer.login,
                                                $commit.committer.id,
                                                $commit.commit.committer.name,
                                                $commit.commit.committer.email,
                                                [Datetime]::Parse($commit.commit.committer.date),
                                                $commit.committer.node_id,
                                                $commit.committer.avatar_url,
                                                $commit.committer.html_url,
                                                $commit.committer.type
                                                ))
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $commitsArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        # Returning the '$commitsArray' array...
        return $commitsArray
    }

    # Definition of a static function to put all commits from a owner (User or Organization) and a repository identified respectively by its login and its name inside an array since a date until another date...
    static [System.Array] listAllCommits([string]$wishedOwnerLogin, [string]$wishedRepositoryName, [bool]$withMissingDatas, [DateTime]$sinceDate, [DateTime]$untilDate)
    {
        # Definition of the 'commitsArray' array which will contain all commits of the wished 'wishedRepositoryName' repo from the wished 'wishedUserLogin' user...
        $commitsArray = [System.Collections.ArrayList]::new()

        # Bloc we wish execute to get all informations about commits...
        try {

            #
            $githubGetCommitsReposURL = "https://api.github.com/repos/" + $wishedOwnerLogin + "/" + $wishedRepositoryName + "/commits?since=" + $sinceDate + "&until=" + $untilDate

            # Retrieving and extracting all commits received from the URL...
            $githubCommitsReposRequest = Invoke-WebRequest -Uri $githubGetCommitsReposURL -Method Get
            $commitsJSONObj = ConvertFrom-Json $githubCommitsReposRequest.Content

            # Browse all the commits contained in the received JSON and create all the instances of the Powershell class 'Commit' from this data and add them to the array 'commitsArray'...
            foreach($commit in $commitsJSONObj) {

                $commitsArray.Add([Commit]::new($commit.sha,
                                                $commit.node_id,
                                                $commit.commit.message,
                                                $commit.author.login,
                                                $commit.author.id,
                                                $commit.commit.author.name,
                                                $commit.commit.author.email,
                                                [Datetime]::Parse($commit.commit.author.date),
                                                $commit.author.node_id,
                                                $commit.author.avatar_url,
                                                $commit.author.html_url,
                                                $commit.author.type,
                                                $commit.committer.login,
                                                $commit.committer.id,
                                                $commit.commit.committer.name,
                                                $commit.commit.committer.email,
                                                [Datetime]::Parse($commit.commit.committer.date),
                                                $commit.committer.node_id,
                                                $commit.committer.avatar_url,
                                                $commit.committer.html_url,
                                                $commit.committer.type
                                                ))
            }

        # Bloc to execute if an System.Net.WebException is encountered...
        } catch [System.Net.WebException] {

            $errorType = $_.Exception.GetType().Name

            $errorMessage = $_.Exception.Message

            $errorStackTrace = $_.Exception.StackTrace

            $commitsArray.Add([GitHubError]::new($errorType, $errorMessage, $errorStackTrace))
        }

        # Returning the '$commitsArray' array...
        return $commitsArray
    }

    #
    [void] completeAllDatas()
    {

    }

    # Returns the Commit current instance as String...
    [String] ToString()
    {

        # If no error occurs...
        If(!$this.error) {

             $returningString = ""

        # Else (an error occurs)...
        } Else {

            $returningString = $this.error.ToString()
        }

        return $returningString
    }

    # Returning the module's type as string...
    [string] getModuleType()
    {
        return "Commit"
    }

    # 'sha' attribute getter...
    [string] getSha()
    {
        return $this.sha
    }

    # 'nodeId' attribute getter...
    [string] getNodeId()
    {
        return $this.nodeId
    }

    # 'message' attribute getter...
    [string] getMessage()
    {
        return $this.message
    }

    # 'loginAuthor' attribute getter...
    [string] getLoginAuthor()
    {
        return $this.loginAuthor
    }

    # 'idAuthor' attribute getter...
    [string] getIdAuthor()
    {
        return $this.idAuthor
    }

    # 'nameAuthor' attribute getter...
    [string] getNameAuthor()
    {
        return $this.nameAuthor
    }

    # 'emailAuthor' attribute getter...
    [string] getEmailAuthor()
    {
        return $this.emailAuthor
    }

    # 'dateAuthor' attribute getter...
    [datetime] getDateAuthor()
    {
        return $this.dateAuthor
    }

    # 'nodeIdAuthor' attribute getter...
    [string] getNodeIdAuthor()
    {
        return $this.nodeIdAuthor
    }

    # 'avatarAuthor' attribute getter...
    [string] getAvatarAuthor()
    {
        return $this.avatarAuthor
    }

    # 'profileAuthor' attribute getter...
    [string] getProfileAuthor()
    {
        return $this.profileAuthor
    }

    # 'typeAuthor' attribute getter...
    [string] getTypeAuthor()
    {
        return $this.typeAuthor
    }

    # 'loginCommitter' attribute getter...
    [string] getLoginCommitter()
    {
        return $this.loginCommitter
    }

    # 'idCommitter' attribute getter...
    [string] getIdCommitter()
    {
        return $this.idCommitter
    }

    # 'nameCommitter' attribute getter...
    [string] getNameCommitter()
    {
        return $this.nameCommitter
    }

    # 'emailCommiter' attribute getter...
    [string] getEmailCommiter()
    {
        return $this.emailCommiter
    }

    # 'dateCommitter' attribute getter...
    [datetime] getDateCommitter()
    {
        return $this.dateCommitter
    }

    # 'nodeIdCommitter' attribute getter...
    [string] getNodeIdCommitter()
    {
        return $this.nodeIdCommitter
    }

    # 'avatarCommitter' attribute getter...
    [string] getAvatarCommitter()
    {
        return $this.avatarCommitter
    }

    # 'profileCommitter' attribute getter...
    [string] getProfileCommitter()
    {
        return $this.profileCommitter
    }

    # 'typeCommitter' attribute getter...
    [string] getTypeCommitter()
    {
        return $this.typeCommitter
    }

    # 'total' attribute getter...
    [int] getTotal()
    {
        return $this.total
    }

    # 'additions' attribute getter...
    [int] getAdditions()
    {
        return $this.additions
    }

    # 'deletions' attribute getter...
    [int] getDeletions()
    {
        return $this.deletions
    }

    # 'files' attribute getter...
    [System.Array] getFiles()
    {
        return $this.files
    }

    # 'error' attribute getter...
    [GitHubError] getGitHubError()
    {
        return $this.error
    }
}