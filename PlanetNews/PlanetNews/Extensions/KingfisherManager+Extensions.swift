import Kingfisher

extension KingfisherManager {
    func cleanCache() {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
    
    func setupKingfisher() {
//        KingfisherManager.shared.cache.memoryStorage.config.countLimit = 50
        KingfisherManager.shared.cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1025
    }
}
