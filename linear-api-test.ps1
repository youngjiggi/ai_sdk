$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "YOUR_LINEAR_API_KEY"
}

$body = @{
    query = "query Teams { teams { nodes { id name } }}"
} | ConvertTo-Json

$response = Invoke-RestMethod -Uri "https://api.linear.app/graphql" -Method Post -Headers $headers -Body $body

$response | ConvertTo-Json -Depth 10 