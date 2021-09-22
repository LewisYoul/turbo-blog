require 'rails_helper'

RSpec.describe PostsUpdater do
  subject(:post_update) { described_class.new(post, params).update_post }

  let(:post) { FactoryBot.create(:post, tags: [tag_1]) }
  let(:tag_1) { FactoryBot.create(:tag, name: 'Ruby') }
  let(:tag_2) { FactoryBot.create(:tag, name: 'JavaScript') }
  let(:tag_3) { FactoryBot.create(:tag, name: 'Python') }

  describe '#update_post' do
    context 'the post params are invalid' do
      context 'a required attribute is unset' do
        let(:params) { { title: nil } }
        
        it "doesn't change the post" do
          expect { post_update }.not_to change { post.reload }
        end
        
        it "doesn't change the post tags" do
          expect { post_update }.not_to change { post.reload.tag_ids }
        end

        it 'confirms that the post has not been updated' do
          expect(post_update.updated?).to be(false)
        end

        it 'returns the errors in the result' do
          expect(post_update.errors[:title]).to eq(["can't be blank"])
        end
      end
      
      context "an id for a tag that doesn't exist is passed" do
        let(:params) { { tag_ids: [300] } }
        
        it 'confirms that the post has not been updated' do
          expect(post_update.updated?).to be(false)
        end

        it "doesn't change the post" do
          expect { post_update }.not_to change { post.reload }
        end

        it "doesn't change the post tags" do
          expect { post_update }.not_to change { post.reload.tag_ids }
        end
      end
    end

    context 'the post params are valid' do
      let(:params) do
        {
          title: 'Updated Title',
          summary: 'Updated Summary',
          body: 'Updated Body',
          tag_ids: [tag_2.id, tag_3.id]
        }
      end

      it { is_expected.to be_an_instance_of(described_class::Result) }

      it 'updates the post title' do
        expect { post_update }.to change { post.title }
          .from('Original Title')
          .to('Updated Title')
      end

      it 'updates the post summary' do
        expect { post_update }.to change { post.summary }
          .from('Original Summary')
          .to('Updated Summary')
      end

      it 'updates the post body' do
        expect { post_update }.to change { post.body }
          .from('Original Body')
          .to('Updated Body')
      end

      it 'updates the tags of the post to be only those with the passed ids' do
        expect { post_update }.to change { post.tag_ids }
          .from([tag_1.id])
          .to([tag_2.id, tag_3.id])
      end

      it 'confirms that the post has been successfully updated' do
        expect(post_update.updated?).to be(true)
      end
      
      it 'returns no errors for the post' do
        expect(post_update.errors).to be_empty
      end
    end
  end
end