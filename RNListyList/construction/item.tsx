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
} from 'react-native';


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
    map: {
        ...StyleSheet.absoluteFillObject,
    },
    container: {
        flex: 2,
        justifyContent: "space-evenly",
        alignItems: "center",
    },
    leftContainer: {
        flex: 1
    }

});

type ConstrutionItemProps = {
    title: string
    imgURL?: string
    address: string
}

const CONSTRUCTION_ITEM_MARGIN = 16;
export const CONSTRUCTION_ITEM_WIDTH = 300 + (CONSTRUCTION_ITEM_MARGIN * 2);

export function ConstructionItem({ title, imgURL, address }: ConstrutionItemProps): JSX.Element {

    imgURL = imgURL ?? "https://geekflare.com/wp-content/uploads/2023/03/img-placeholder.png"

    return (
        <View style={{
            width: CONSTRUCTION_ITEM_WIDTH,
            height: 150,
            backgroundColor: "#ffffffff",
            marginVertical: 8,
            marginHorizontal: CONSTRUCTION_ITEM_MARGIN,
            display: "flex",
            flexDirection: "row",
            justifyContent: "space-evenly",
        }}>
            <View
                style={{
                    ...styles.container,
                    ...styles.leftContainer,
                }}
            >
                <Image
                    style={styles.tinyLogo}
                    source={{
                        uri: imgURL,
                    }}
                />
            </View>
            <View
                style={{
                    ...styles.container,
                }}
            >
                <Text>{title}</Text>
                <Text>{address}</Text>
            </View>
        </View>
    )
}
