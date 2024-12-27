url = f"{BASE_URL}/Locations"
headers = {"Authorization": f"Bearer {API_KEY}"}

all_records = []

try:
    while True:
        response = requests.get(url, headers=headers, params={"view": "Grid view", "maxRecords": 100})
        response.raise_for_status() 
        data = response.json()
        
        all_records.extend(data.get("records", []))
        
        offset = data.get("offset")
        if not offset:
            break 
        else:
            url = f"{BASE_URL}/Locations?offset={offset}"  
    
    print("\nAll Food Courts:")
    for record in all_records:
        fields = record.get("fields", {})
        print(fields)

except requests.exceptions.RequestException as e:
    print(f"Error fetching food outlets: {e}")
