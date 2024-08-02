//
//  SwiftDataTestView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/26/24.
//

import SwiftUI
import SwiftData

struct SwiftDataTestView : View {
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \LogicalSpeakingRecord.id) var records: [LogicalSpeakingRecord]
    
    var body: some View {
        ForEach(0..<records.count, id:\.self) { recordIndex in
            VStack {
                ForEach (0..<records[recordIndex].speakingStructure.rawValue.count, id : \.self) { index in
                    
                    Text("\(records[recordIndex].content[index])")
                    
                    Divider()
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container : ModelContainer = {
        let schema = Schema([LogicalSpeakingRecord.self])
        
        do {
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    let testRecord = LogicalSpeakingRecord(
        topic: "스티브잡스 스탠포드 연설 중 발췌",
        speakingStructure: .star,
        content: [
            
            .init(topContent: "P", bodyContent:
                        """
                        들려 드릴 첫 번째 이야기는 점 잇기에 관한 것입니다.
                        
                        Reed College에 입학한 지 6 개월 만에 자퇴를 했으나 일 년 반 정도 청강생활을 하면서 머물렀습니다. 그렇다면 왜 제가 자퇴를 했을까요?
                        """
                  
                  , isScript: true),
            .init(topContent: "r", bodyContent:
                    """
                    제가 인생에서 하고 싶은 것이 무엇인 지, 대학 교육이 어떤 도움이 될지 갈피를 잡을 수가 없었습니다. 그리고 저는 부모님이 평생 모은 돈을 까먹고 있었죠.
                    """, isScript: true),
            .init(topContent: "r", bodyContent:
                    """
                    그래서 자퇴를 결심했고, 모든 일이 잘 될 거라고 믿었습니다. 당시에는 꽤 두려웠지만, 돌아보면, 제가 인생에서 내린 최고의 결정 가운데 하나였습니다.
                    
                    자퇴를 하고 나니, 관심 없었던 필수과목 대신 듣고 싶었던 강의를 청강할 수 있었습니다.
                    
                    자퇴를 했으니 정규 과목을 들을 필요도 없었기 때문에, 서체 수업을 듣기로 작정했습니다.
                    
                    세리프와 산 세리프 서체를 배웠는데 서로 다른 자모의 결합에 따라서 자간을 달리 둠으로써 훌륭한 서체를 그리는 것이었습니다.
                    
                    그것은 아름다웠고, 역사적으로 유명했으며, 과학은 따라갈 수 없는 섬세한 예술이었습니다. 저는 여기에 매료되었죠.
                    """
                  , isScript: true),
            .init(topContent: "r", bodyContent:
                    """
                    제가 만약에 그때 서체 수업을 청강하지 않았더라면, 매킨토시는 다중 서체나 비례적으로 자간을 조정하는 글꼴을 가지지도 못했을 겁니다. 그리고 윈도우즈가 맥을 그대로 따라 했으니까, 매킨토시뿐만 아니라 그 어떤 퍼스널 컴퓨터도 비슷한 처지에 놓였겠죠.
                    자퇴를 하지 않았더라면, 서체 수업을 청강하지 않았을 테니, 퍼스널 컴퓨터는 오늘날과 같은 훌륭한 인쇄술을 가지지도 못했을 겁니다.
                    
                    물론, 제가 대학에 있었을 때에는 이런 미래의 점들을 이을 수가 없었습니다. 그러나 10년이 지난 후, 과거를 돌아보았을 때, 모든 게 분명히 보였습니다.
                                                                                                              
                    다시 말씀드리지만, 우리는 미래의 점들을 이을 수는 없습니다. 과거의 점들만 이을 수 있는 거죠. 그러므로 이런 점들이 미래에 어떤 식으로든 이어진다고 믿어야 합니다.
                    """
                  , isScript: true)
            
        ],
        duration: 0,
        isDone: true,
        designatedTimestamp: Date(),
        isFreeTopic: true
    )
    
    container.mainContext.insert(testRecord)
    
    return SwiftDataTestView()
        .modelContainer(container)
}



