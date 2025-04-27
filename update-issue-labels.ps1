$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "YOUR_LINEAR_API_KEY"
}

$teamId = "98c65e3b-c9be-45e5-927f-d945d4b81270"  # "My dear cursor" team ID

# List of issues to update with numerical reference
$issues = @(
    @{
        id = "d3654c54-980d-4ab5-902b-2c12c4940596"
        newTitle = "3.1 - Integrate Vercel AI SDK for chatbot functionality"
        originalTitle = "Integrate Vercel AI SDK for chatbot functionality"
    },
    @{
        id = "eed056d4-660b-40a9-95d5-6e1a46f65b9c"
        newTitle = "3.2 - Implement custom tool for Financial Modeling Prep (FMP) API"
        originalTitle = "Implement custom tool for Financial Modeling Prep (FMP) API"
    },
    @{
        id = "88447a77-2d09-4534-b67c-cb6ccf482373"
        newTitle = "3.3 - Set up Vercel xAI/Grok Integration"
        originalTitle = "Set up Vercel xAI/Grok Integration"
    },
    @{
        id = "1f44325b-a355-433c-a14c-a4347e0c0fec"
        newTitle = "3.4 - Implement TAB Context Functionality"
        originalTitle = "Implement TAB Context Functionality"
    },
    @{
        id = "14e3d5b4-305d-4110-a9b5-7adf3dc4f532"
        newTitle = "3.5 - Enhance Grok chatbot with additional custom tools"
        originalTitle = "Enhance Grok chatbot with additional custom tools"
    }
)

# Update the issue titles with numerical references
foreach ($issue in $issues) {
    Write-Output "Updating issue title: $($issue.originalTitle) to $($issue.newTitle)"
    
    $updateTitleMutation = @"
mutation {
  issueUpdate(
    id: "$($issue.id)",
    input: {
      title: "$($issue.newTitle)"
    }
  ) {
    success
    issue {
      id
      title
    }
  }
}
"@
    
    $updateBody = @{
        query = $updateTitleMutation
    } | ConvertTo-Json
    
    $updateResponse = Invoke-RestMethod -Uri "https://api.linear.app/graphql" -Method Post -Headers $headers -Body $updateBody
    
    if ($updateResponse.data.issueUpdate.success) {
        Write-Output "Successfully updated issue title to: $($updateResponse.data.issueUpdate.issue.title)"
    } else {
        Write-Error "Failed to update issue $($issue.id)"
    }
} 