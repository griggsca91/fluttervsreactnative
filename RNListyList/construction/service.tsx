import { Location } from './location'

export async function getLocations(): Promise<Location[]> {
    const results = await fetch('http://10.0.2.2:3000/locations').then((r) => r.json());
    return (results as response).locations.map(v => ({
        lat: v.lat,
        long: v.long,
        displayName: v.display_name,
        displayImage: v.display_image,
        address: v.address,
    } as Location))
}

type response = {
    locations: {
        lat: number,
        long: number,
        display_name: string,
        address: string,
        display_image?: string,
    }[],
}

