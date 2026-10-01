package server

type FeedScheduler interface {
	FeedsPending() int32
	RefreshFeeds()
	SetRefreshRate(minutes int64)
}
