#!/bin/bash

OUTPUT_DIR="/reports"
mkdir -p $OUTPUT_DIR

response=$(curl -s "https://huggingface.co/api/models?sort=downloads")

if [ -z "$response" ]; then
    echo "Failed to fetch data from Hugging Face"
    exit 1
fi

top_models=$(echo "$response" | jq -r '[
    .[:10] | 
    {
        models: [
            .[] | 
            {
                "Model ID": .modelId,
                "Downloads": .downloads,
                "Author": .author,
                "Last Modified": .lastModified
            }
        ]
    }
]')

timestamp=$(date +'%Y%m%d_%H%M%S')
report_file="$OUTPUT_DIR/top_10_models_report_${timestamp}.json"

echo "$top_models" | jq . > "$report_file"

echo "Report generated at $report_file"
