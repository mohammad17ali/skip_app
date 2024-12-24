from flask import Flask, jsonify, request
import requests

app = Flask(__name__)

# Airtable API details
AIRTABLE_BASE_URL = "https://api.airtable.com/v0/appWaAdFLtWA1IAZM"
AIRTABLE_API_KEY = "YOUR_SECRET_API_TOKEN"

HEADERS = {
    "Authorization": f"Bearer {AIRTABLE_API_KEY}"
}


def fetch_airtable_data(endpoint, params=None):
    """Fetch data from Airtable."""
    url = f"{AIRTABLE_BASE_URL}/{endpoint}"
    response = requests.get(url, headers=HEADERS, params=params)
    response.raise_for_status()  # Raise HTTPError for bad responses
    return response.json()


@app.route('/home_page', methods=['GET'])
def get_home_page():
    """API to fetch food courts and their respective outlets."""
    try:
        # Fetch food courts (Locations)
        locations_data = fetch_airtable_data("Locations", {"view": "Grid view"})
        locations = locations_data.get("records", [])

        # Fetch food outlets (Outlets)
        outlets_data = fetch_airtable_data("Outlets", {"view": "Grid view"})
        outlets = outlets_data.get("records", [])

        # Organize outlets by Location_ID
        outlets_by_location = {}
        for outlet in outlets:
            location_id = outlet["fields"].get("Location_ID")
            if location_id:
                outlets_by_location.setdefault(location_id, []).append({
                    "Outlet_ID": outlet["fields"].get("Outlet_ID"),
                    "Name": outlet["fields"].get("Name"),
                    "Phone": outlet["fields"].get("Phone"),
                    "Email": outlet["fields"].get("Email"),
                    "Products": outlet["fields"].get("Products"),
                    "Image": outlet["fields"].get("Image", [])
                })

        # Structure response data
        food_courts = []
        for location in locations:
            location_id = location["fields"].get("Location_ID")
            food_courts.append({
                "Location_ID": location_id,
                "Location_Name": location["fields"].get("Location"),
                "Outlets": outlets_by_location.get(location_id, [])
            })

        return jsonify({"food_courts": food_courts}), 200

    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)
