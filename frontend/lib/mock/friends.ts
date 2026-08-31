// TEMPORARY: the friendship system does not exist in the backend yet. Every profile renders this
// same fixture so the UI can be built and reviewed. Delete this file once the real endpoints land
// and swap the imports in components/profile/ for a friendService.

export interface Friend {
  username: string;
  avatarUrl: string;
  description: string;
  status: string;
}

export interface FriendRequest {
  username: string;
  avatarUrl: string;
  description: string;
  createdAt: number;
}

const minute = 60 * 1000;
const hour = 60 * minute;
const day = 24 * hour;

export const mockFriends: Friend[] = [
  {
    username: "ahtalha",
    avatarUrl: "",
    description: "coğrafya sorularında kimse beni yenemez",
    status: "online"
  },
  {
    username: "lareii",
    avatarUrl: "",
    description: "backend'i ben yazdım, bug'ları sen buldun",
    status: "online"
  },
  {
    username: "eyilmaz",
    avatarUrl: "",
    description: "her gün 10 soru, hiç şaşmaz",
    status: "online"
  },
  {
    username: "mkarakas",
    avatarUrl: "",
    description: "",
    status: "offline"
  },
  {
    username: "sdemirci",
    avatarUrl: "",
    description: "müzik kategorisi dışında oynamam",
    status: "offline"
  },
  {
    username: "byildirim",
    avatarUrl: "",
    description: "42 Kocaeli",
    status: "offline"
  },
  {
    username: "zaydin",
    avatarUrl: "",
    description: "tarih sorularını bana bırakın",
    status: "online"
  },
  {
    username: "korhan",
    avatarUrl: "",
    description: "",
    status: "offline"
  }
];

export const mockFriendRequests: FriendRequest[] = [
  {
    username: "cozturk",
    avatarUrl: "",
    description: "aynı odada takılmıştık",
    createdAt: Date.now() - 12 * minute
  },
  {
    username: "nkaya",
    avatarUrl: "",
    description: "",
    createdAt: Date.now() - 5 * hour
  },
  {
    username: "tguler",
    avatarUrl: "",
    description: "bilim kategorisinde 10/10",
    createdAt: Date.now() - 2 * day
  }
];
