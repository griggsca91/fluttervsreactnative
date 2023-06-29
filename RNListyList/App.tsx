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


function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
   <View style={styles.container}>
      <MapView
             style={styles.map}

             region={{
              latitude: 37.78825,
              longitude: -122.4324,
              latitudeDelta: 0.015,
              longitudeDelta: 0.0121,
            }}
     />
      <ConstructionList />
      </View>
    </SafeAreaView>
  );
}

function ConstructionList() {
      return (
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
      )
}

type ConstrutionItemProps = {
  title: string
  imgURL?: string
}

function ConstructionItem({title, imgURL}: ConstrutionItemProps): JSX.Element {
  
  imgURL = imgURL ?? "https://geekflare.com/wp-content/uploads/2023/03/img-placeholder.png"
  
  return (
    <View>
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
    justifyContent: 'flex-end',
    alignItems: 'center',
  },
  map: {
    ...StyleSheet.absoluteFillObject,
  },
 
});

export default App;
