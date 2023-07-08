/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import { useEffect, useState } from 'react';
import {
  SafeAreaView,
  ScrollView,
  Image,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  FlatList,
} from 'react-native';

import { ConstructionList } from './construction/list_view';
import { ConstructionMap } from './construction/map_view';
import { Location } from './construction/location';
import { getLocations } from './construction/service';
import { NavigationContainer, NavigationProp } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { DetailView } from './construction/detail';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';


const Stack = createNativeStackNavigator<RootStackParamList>();


function App(): JSX.Element {

  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          name="Home"
          component={HomeScreen}
          options={{ title: "So much construction" }}
        />
        <Stack.Screen
          name="Detail"
          component={DetailView}
          options={{ title: "So much construction" }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}


type RootStackParamList = {
  Home: undefined,
  Detail: { location: Location }
};


type HomeScreenProps = NativeStackScreenProps<RootStackParamList, 'Home'>;



function HomeScreen({navigation}: HomeScreenProps) {
  const [locations, setLocations] = useState([] as Location[])
  useEffect(() => {
    getLocations().then(locations => {
      setLocations(locations);
    });
  }, [])

  return (
    <SafeAreaView style={styles.container}>
      <ConstructionMap locations={locations} />
      <ConstructionList locations={locations} onClick={(location) => navigation.push("Detail", {location})} />
    </SafeAreaView>
  )
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

export default App;
