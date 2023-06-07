#!/bin/bash

# Pobranie tekstu z PDF
pdftotext input.pdf pdf_to_text.txt
tresc=$(cat pdf_to_text.txt)

# Tłumaczenie zawartości pliku pdf za pomocą OpenAI
curl -s -X POST https://oa-demo.openai.azure.com/openai/deployments/TranslatePDF/chat/completions?api-version=2023-05-15 \
-H "Content-Type: application/json" \
-H "api-key: 76c52036c010421e88207261a472e518" \
-d '{
 "messages":[{"role": "system", "content": "Translate the following to Polish:\n\n $(echo $tresc)"}]
}' > pdf_in_polish.txt

# Zapisanie wyniku tłumaczenia do pliku txt
cat pdf_in_polish.txt | jq '.choices[0].message.content' | cut -c2- | rev | cut -c2- | rev
