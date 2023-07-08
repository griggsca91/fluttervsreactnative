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
    Dimensions,
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

import { ConstructionItem, CONSTRUCTION_ITEM_WIDTH } from './item';
import { Location } from './location';
const { width } = Dimensions.get('window');
console.log(width - CONSTRUCTION_ITEM_WIDTH);

const styles = StyleSheet.create({
    list: {
        position: "absolute",
        height: 200,
        bottom: 0,
    }
});

type ConstructionListProps = {
    locations: Location[],
    onClick: (location: Location) => void,
}

export function ConstructionList({ locations, onClick }: ConstructionListProps) {
    return (
        <View
            style={styles.list}
        >
            <FlatList
                data={locations}
                horizontal
                snapToAlignment="center"
                decelerationRate={0}
                pagingEnabled
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

