# Linear API Tools for AI SDK Development

A collection of PowerShell scripts for managing Linear issues and workflows for the AI SDK development branch of the ProMerge Tracks project.

## Scripts

### linear-api-test.ps1
A simple script to test the Linear API connection and retrieve team information.

### linear-api-issues.ps1
Creates a set of predefined issues in Linear for the AI SDK branch work.

### update-issue-labels.ps1
Updates issue titles with a numerical reference system (e.g., 3.1, 3.2) and can apply labels.

## Usage

Replace `YOUR_LINEAR_API_KEY` in the scripts with your actual Linear API token before running.

```powershell
# Test Linear API connection
.\linear-api-test.ps1

# Create AI SDK branch issues
.\linear-api-issues.ps1

# Update issue titles with numerical references
.\update-issue-labels.ps1
```

## AI SDK Branch Issues

The scripts create and manage the following issues for the AI SDK branch work:

1. **3.1 - Integrate Vercel AI SDK for chatbot functionality**
2. **3.2 - Implement custom tool for Financial Modeling Prep (FMP) API**
3. **3.3 - Set up Vercel xAI/Grok Integration**
4. **3.4 - Implement TAB Context Functionality**
5. **3.5 - Enhance Grok chatbot with additional custom tools**

## Security Note

Never commit API keys to version control. The scripts use placeholders that should be replaced locally. 