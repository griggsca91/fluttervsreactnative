import React from 'react';
import {
    SafeAreaView,
    StyleSheet,
} from 'react-native';
import { Location } from './location';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';


const styles = StyleSheet.create({
    container: {
        ...StyleSheet.absoluteFillObject,
        flex: 1, //the container will fill the whole screen.
        justifyContent: "flex-end",
        alignItems: "center",
    },
});

type RootStackParamList = {
    Home: undefined,
    Detail: { location: Location }
  };
  
  
  type DetailViewProps = NativeStackScreenProps<RootStackParamList, 'Detail'>;
  

export function DetailView({route}:DetailViewProps) {
    const {location} = route.params;
    console.log("location", location);
    return (
        <SafeAreaView style={styles.container}>
      </SafeAreaView>
    )
}