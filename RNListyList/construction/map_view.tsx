import React, { useRef, useEffect } from 'react';
import {
    StyleSheet,
} from 'react-native';

import MapView, { LatLng } from 'react-native-maps';
import { Marker } from "react-native-maps";
import { Location } from './location';


type ConstructionMapProps = {
    locations: Location[],
    goTo: LatLng,
}


export function ConstructionMap({ locations, goTo }: ConstructionMapProps) {
    const map = useRef<MapView>(null);
    const markers = locations.map((v) => {
        return <Marker
            key={v.address}
            coordinate={{
                latitude: Number(v.lat),
                longitude: Number(v.long),
            }}
        />
    })
    
    return (<MapView
        style={styles.map}
        ref={map}
        initialRegion={{
            ...goTo,
            latitudeDelta: 0.015,
            longitudeDelta: 0.0121,
        }}
        region={{
            ...goTo,
            latitudeDelta: 0.015,
            longitudeDelta: 0.0121,
        }}
    >
        {markers}
    </MapView>)
}


const styles = StyleSheet.create({
    sectionContainer: {
        marginTop: 32,
        paddingHorizontal: 24,
    },
    sectionTitle: {
        fontSize: 24,
        fontWeight: '600',
    },
    sectionDescription: {
        marginTop: 8,
        fontSize: 18,
        fontWeight: '400',
    },
    highlight: {
        fontWeight: '700',
    },
    tinyLogo: {
        width: 50,
        height: 50,
    },
    container: {
        ...StyleSheet.absoluteFillObject,
        flex: 1, //the container will fill the whole screen.
        justifyContent: "flex-end",
        alignItems: "center",
    },
    map: {
        ...StyleSheet.absoluteFillObject,
    },

});
