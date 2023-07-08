import React from 'react';
import {
    StyleSheet,
    View,
    FlatList,
    TouchableOpacity,
} from 'react-native';

import { ConstructionItem } from './item';
import { Location } from './location';

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
    onLongPress: (location: Location) => void,
}

export function ConstructionList({ locations, onClick, onLongPress }: ConstructionListProps) {
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
                        <TouchableOpacity
                            onLongPress={() => onLongPress(item)}
                            onPress={() => onClick(item)}
                        >
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

