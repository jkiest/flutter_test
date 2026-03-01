import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.reviewsCount,
    required this.minPrice,
    required this.images,
    required this.amenities,
    required this.isAvailable,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) =>
      _$HotelFromJson(json);

  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final double latitude;
  final double longitude;
  final double rating;
  final int reviewsCount;
  final double minPrice;
  final List<String> images;
  final List<String> amenities;
  final bool isAvailable;

  Map<String, dynamic> toJson() => _$HotelToJson(this);

  Hotel copyWith({
    String? id,
    String? name,
    String? description,
    String? city,
    String? address,
    double? latitude,
    double? longitude,
    double? rating,
    int? reviewsCount,
    double? minPrice,
    List<String>? images,
    List<String>? amenities,
    bool? isAvailable,
  }) =>
      Hotel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        city: city ?? this.city,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        rating: rating ?? this.rating,
        reviewsCount: reviewsCount ?? this.reviewsCount,
        minPrice: minPrice ?? this.minPrice,
        images: images ?? this.images,
        amenities: amenities ?? this.amenities,
        isAvailable: isAvailable ?? this.isAvailable,
      );
}

@JsonSerializable()
class Room {
  Room({
    required this.id,
    required this.hotelId,
    required this.roomType,
    required this.capacity,
    required this.price,
    required this.features,
    required this.images,
    required this.availableRooms,
  });

  factory Room.fromJson(Map<String, dynamic> json) =>
      _$RoomFromJson(json);

  final String id;
  final String hotelId;
  final String roomType;
  final int capacity;
  final double price;
  final List<String> features;
  final List<String> images;
  final int availableRooms;

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
