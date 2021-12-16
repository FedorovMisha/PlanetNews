import Kingfisher

extension KingfisherManager {
    func cleanCache() {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
}
