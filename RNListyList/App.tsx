/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import type {PropsWithChildren} from 'react';
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

import data from './data.json'

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import MapView from 'react-native-maps';
import { Marker } from "react-native-maps";


function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    flex: 1,
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  const markers = data.data.map((v) => {
    return   <Marker
    key={v.address}
    coordinate={{
      latitude: Number(v.lat),
      longitude: Number(v.long),
    }}
  />

  })

  return (
    <SafeAreaView style={styles.container}>
      <MapView
             style={styles.map}

             region={{
              latitude: 38.698603,
              longitude: -77.2136148,
              latitudeDelta: 0.015,
              longitudeDelta: 0.0121,
            }}
     >
      {markers}
     </MapView>
      <ConstructionList />
    </SafeAreaView>
  );
}

function ConstructionList() {
      return (
        <View
        style={{
         position: "absolute",
         height: 200, 
         bottom: 0,
        }}
        >
      <FlatList
              data={data.data}
              horizontal={true}
              renderItem={({item}) => <ConstructionItem 
              title={item.display_name} 
              imgURL={item.display_image}
              />
            }
              keyExtractor={item => item.display_name}      
      >
      </FlatList>
      </View>
      )
}

type ConstrutionItemProps = {
  title: string
  imgURL?: string
}

function ConstructionItem({title, imgURL}: ConstrutionItemProps): JSX.Element {
  
  imgURL = imgURL ?? "https://geekflare.com/wp-content/uploads/2023/03/img-placeholder.png"
  
  return (
    <View style={{
      width: 200,
      height: 150,
      backgroundColor: "#ffffffff",
      marginVertical: 8,
      marginHorizontal: 16,  
    }}>
      <Image
            style={styles.tinyLogo}
            source={{
              uri: imgURL,
            }}
      />
      <Text>{title}</Text> 
    </View>
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
