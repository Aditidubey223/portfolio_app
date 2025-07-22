import '../models/project.dart';

final List<Project> projectList = [
  Project(
    title: "Minimal Natural Branding",
    subtitle: "Brand identity & logo design",
    bannerImage: "assets/projects/branding_banner.jpg",
    category: "UI/UX",
    description: "A slow-living wellness brand with natural tones and clean design.",
    problem: "Client needed a brand identity for a natural skincare brand.",
    solution: "Designed logo, product packaging, brand colors and fonts.",
    githubLink: "",
    liveLink: null,
    gallery: null,
  ),
  Project(
    title: "Food Expiry Tracker App",
    subtitle: "Mobile Flutter App",
    bannerImage: "assets/projects/foodtracker.jpg",
    category: "Mobile",
    description: "Tracks food & medicine expiry with notifications.",
    problem: "Users forget expiry dates of perishable products.",
    solution: "Built a cross-platform mobile app with reminder logic.",
    githubLink: "https://github.com/aditidubey/food-expiry-tracker",
    liveLink: null,
    gallery: ["assets/projects/foodtracker_1.jpg", "assets/projects/foodtracker_2.jpg"],
  ),
];
