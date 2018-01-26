'use strict';

import React from 'react';
import ReactNative, {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
} from 'react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 100,
    alignItems: 'center',
    backgroundColor: 'white',
  },
  instructions: {
    fontSize: 20,
    color: 'black',
    marginBottom: 20,
  },
  ratings: {
    flexDirection: 'row',
  },
  icon: {
    width: 52,
    height: 58,
    margin: 5,
  },
});

class Rating extends React.Component {
  // 1
  _onPress(rating) {
    if (this.props.ratingSelectionHandler) {
      this.props.ratingSelectionHandler(rating);
    }
  }

  render() {
    // 2
    var ratings = [];
    for (var k = 1; k <= 5; k++) {
      var key = 'rating-' + k;
      // 3
      var ratingImage =
        k <= this.props.rating ? (
          <Image style={styles.icon} source={require('./images/star_on.png')} />
        ) : (
          <Image
            style={styles.icon}
            source={require('./images/star_off.png')}
          />
        );
      // 4
      var rating = (
        <TouchableOpacity key={key} onPress={this._onPress.bind(this, k)}>
          {ratingImage}
        </TouchableOpacity>
      );
      ratings.push(rating);
    }
    // 5
    return (
      <View style={styles.container}>
        <Text style={styles.instructions}>
          What did you think about this mixer?
        </Text>
        <View style={styles.ratings}>{ratings}</View>
      </View>
    );
  }
}

module.exports = Rating;
