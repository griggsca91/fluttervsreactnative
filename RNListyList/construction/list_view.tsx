import React from 'react';
import type { PropsWithChildren } from 'react';
import {
    SafeAreaView,
    ScrollView,
    Image,
    StyleSheet,
    Text,
    useColorScheme,
    View,
    FlatList,
    TouchableOpacity,
} from 'react-native';

import {
    Colors,
    DebugInstructions,
    Header,
    LearnMoreLinks,
    ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import MapView from 'react-native-maps';
import { Marker } from "react-native-maps";

import { ConstructionItem } from './item';
import { Location } from './location';


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

type ConstructionListProps = {
    locations: Location[],
    onClick: (location: Location) => void,
}

export function ConstructionList({ locations, onClick }: ConstructionListProps) {
    return (
        <View
            style={{
                position: "absolute",
                height: 200,
                bottom: 0,
            }}
        >
            <FlatList
                data={locations}
                horizontal={true}
                renderItem={function ({ item }) {
                    return (
                        <TouchableOpacity onPress={() => onClick(item)}>
                            <ConstructionItem
                    key={item.address}
                    title={item.displayName}
                    imgURL={item.displayImage}
                    address={item.address}
                />
                </TouchableOpacity>
                    )
                }
            }
                keyExtractor={item => item.displayName}
            >
            </FlatList>
        </View>
    )
}

