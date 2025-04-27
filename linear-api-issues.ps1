$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "YOUR_LINEAR_API_KEY"
}

$teamId = "98c65e3b-c9be-45e5-927f-d945d4b81270"  # "My dear cursor" team ID

# Create an issue function
function Create-LinearIssue {
    param (
        [string]$title,
        [string]$description,
        [string]$teamId
    )
    
    # Escape newlines, quotes and backslashes for GraphQL
    $escapedDescription = $description -replace '\\', '\\\\' -replace "`r`n", '\n' -replace "`n", '\n' -replace '"', '\"'
    
    $mutation = @"
mutation {
  issueCreate(input: {
    title: "$title",
    description: "$escapedDescription",
    teamId: "$teamId"
  }) {
    success
    issue {
      id
      title
    }
  }
}
"@
    
    $body = @{
        query = $mutation
    } | ConvertTo-Json
    
    $response = Invoke-RestMethod -Uri "https://api.linear.app/graphql" -Method Post -Headers $headers -Body $body
    return $response
}

# Define issues for the ai-sdk branch
$issues = @(
    @{
        title = "Integrate Vercel AI SDK for chatbot functionality"
        description = "Set up and integrate the Vercel AI SDK to provide chatbot functionality in the dashboard.

Tasks:
- Install AI SDK package (npm install ai)
- Set up environment variables for AI provider (XAI_API_KEY)
- Integrate useChat hook into frontend components
- Customize chat interface to fit dashboard layout
- Implement 'TAB context' functionality

Branch: ai-sdk"
    },
    @{
        title = "Implement custom tool for Financial Modeling Prep (FMP) API"
        description = "Create and integrate a custom tool for the FMP API with the Grok chatbot.

Tasks:
- Define the tool schema
- Implement logic to fetch data from FMP API
- Register the tool with the Grok chatbot
- Deploy as a Next.js API route

Branch: ai-sdk"
    },
    @{
        title = "Set up Vercel xAI/Grok Integration"
        description = "Integrate the xAI/Grok model with our application.

Tasks:
- Connect to Vercel Project
- Pull Environment Variables
- Install AI SDK
- Create chatbot component for the left panel
- Implement chat UI with message history and input field

Branch: ai-sdk"
    },
    @{
        title = "Implement TAB Context Functionality"
        description = "Create a system for the chatbot to understand context from different dashboard panels.

Tasks:
- Create TAB mode to allow selecting panels for context
- Implement mechanism to extract content from selected panels
- Add logic to incorporate panel content into chat context

Branch: ai-sdk"
    },
    @{
        title = "Enhance Grok chatbot with additional custom tools"
        description = "Expand the capabilities of the Grok chatbot with additional tools and features.

Tasks:
- Research and implement additional AI tools
- Add context-aware features
- Test AI functionality with various user scenarios

Branch: ai-sdk"
    }
)

# Create each issue
foreach ($issue in $issues) {
    try {
        $result = Create-LinearIssue -title $issue.title -description $issue.description -teamId $teamId
        Write-Output "Created issue: $($issue.title)"
        Write-Output "Response: $($result | ConvertTo-Json -Depth 3)"
    } catch {
        Write-Error "Failed to create issue: $($issue.title)"
        Write-Error $_.Exception.Message
    }
} 