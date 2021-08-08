require 'rails_helper'

RSpec.describe TasksController do
  let(:random_user){ create(:random_user) }
  let(:task){ build(:task) }
  describe "Get index" do

    context "Get index successfully" do
      it "tasks order by id" do
        login(random_user)

        task1 = current_user.tasks.create(attributes_for(:task))
        task2 = current_user.tasks.create(attributes_for(:task))

        get :index

        expect(assigns[:tasks]).to eq([task2, task1])
      end

      it "Response is success" do
        login(random_user)

        task1 = current_user.tasks.create(attributes_for(:task))
        task2 = current_user.tasks.create(attributes_for(:task))

        get :index

        expect(response).to be_successful
      end

      it "render index" do
        login(random_user)

        task1 = current_user.tasks.create(attributes_for(:task))
        task2 = current_user.tasks.create(attributes_for(:task))

        get :index

        expect(response).to render_template(:index)
      end

      it "http status is 200" do
        login(random_user)
  
        task1 = current_user.tasks.create(attributes_for(:task))
        task2 = current_user.tasks.create(attributes_for(:task))
  
        get :index

        expect(response).to have_http_status(200)
      end
    end
  end

  describe "Get new" do
    it "response is success" do
      login(random_user)

      get :new

      expect(response).to be_successful
    end

    it "render new" do
      login(random_user)

      get :new

      expect(response).to render_template(:new)
    end


    it "http status is 200" do
      login(random_user)

      get :new

      expect(response).to have_http_status(200)
    end
  end

  describe "Get show" do
    it "same task" do
      login(random_user)
      
      task = current_user.tasks.create(attributes_for(:task))

      get :show, params: {id: task.id}

      expect(assigns[:task]).to eq(task)
    end

    it "response is success" do
      login(random_user)
      
      task = current_user.tasks.create(attributes_for(:task))

      get :show, params: {id: task.id}

      expect(response).to be_successful
    end

    it "render show" do
      login(random_user)
      
      task = current_user.tasks.create(attributes_for(:task))

      get :show, params: {id: task.id}

      expect(response).to render_template(:show)
    end

    it "http status 200" do
      login(random_user)
      
      task = current_user.tasks.create(attributes_for(:task))

      get :show, params: {id: task.id}

      expect(response).to have_http_status(200)
    end
  end

  describe "Get edit" do
    it "same task" do
      login(random_user)
      
      task = current_user.tasks.create(attributes_for(:task))

      get :edit, params: {id: task.id}

      expect(assigns[:task]).to eq(task)
    end

    it "response is success" do
      login(random_user)
      
      task = current_user.tasks.create(attributes_for(:task))

      get :edit, params: {id: task.id}

      expect(response).to be_successful
    end

    it "render edit" do
      login(random_user)
      
      task = current_user.tasks.create(attributes_for(:task))

      get :edit, params: {id: task.id}

      expect(response).to render_template(:edit)
    end

    it "http status is 200" do
      login(random_user)
      
      task = current_user.tasks.create(attributes_for(:task))

      get :edit, params: {id: task.id}

      expect(response).to have_http_status(200)
    end
  end

  describe "Post create" do

    # Normal

    context "Task add successfully" do
      it "count + 1" do
        login(random_user)
        expect { post :create, params: { task: attributes_for(:task) } }.to change(Task, :count).by(1)
      end
  
      it "redirect to task index" do
        login(random_user)
        post :create, params: { task: attributes_for(:task) }
        expect(response).to redirect_to tasks_path
      end
    end

    # Validations
    
    context "Task add failed without title" do
      it "Count doesn\'t plus 1" do
        login(random_user)
        expect { post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'title'} } }.to change(Task, :count).by(0)
      end
  
      it "render new" do
        login(random_user)
        post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'title'} }
        expect(response).to render_template(:new)
      end
    end

    context "Task add failed without start time" do
      it "Count doesn\'t plus 1" do
        login(random_user)
        expect { post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'start_time'} } }.to change(Task, :count).by(0)
      end

      it "render new" do
        login(random_user)
        post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'start_time'} }
        expect(response).to render_template(:new)
      end
    end
    
    context "Task add failed without end time" do   
      it "Count doesn\'t plus 1" do
        login(random_user)
        expect { post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'end_time'} } }.to change(Task, :count).by(0)
      end

      it "render new" do
        login(random_user)
        post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'end_time'} }
        expect(response).to render_template(:new)
      end
    end

    context "Task add failed without priority" do
      it "Count doesn\'t plus 1" do
        login(random_user)
        expect { post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'priority'} } }.to change(Task, :count).by(0)
      end
  
      it "render new" do
        login(random_user)
        post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'priority'} }
        expect(response).to render_template(:new)
      end
    end

    context "Task add failed without state" do
      it "Count doesn\'t plus 1" do
        login(random_user)
        expect { post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'state'} } }.to change(Task, :count).by(0)
      end
  
      it "render new" do
        login(random_user)
        post :create, params: { task: attributes_for(:task).delete_if{|key, val| key.to_s == 'state'} }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "Patch update" do
    context "Update task successfully" do
      it "same task" do
        login(random_user)
        
        task = current_user.tasks.create(attributes_for(:task))
  
        patch :update, params: { id: task.id, task: { title: '123' } }
        expect(assigns[:task]).to eq(task)
      end
  
      it "change value" do
        login(random_user)
        
        task = current_user.tasks.create(attributes_for(:task))
  
        patch :update, params: { id: task.id, task: { title: '123' } }
        expect(assigns[:task].title).to eq('123')
      end
  
      it "redirect to tasks" do
        login(random_user)
        
        task = current_user.tasks.create(attributes_for(:task))
  
        patch :update, params: { id: task.id, task: { title: '123' } }
        expect(response).to redirect_to tasks_path
      end
    end
  end

  describe "Delete destroy" do
    
    context "task delete successfully" do
      it "same task" do
        login(random_user)
        task = current_user.tasks.create(attributes_for(:task))
  
        delete :destroy, params: { id: task.id }
        expect(assigns[:task]).to eq(task)
      end
  
      it "count -1" do
        login(random_user)
        task = current_user.tasks.create(attributes_for(:task))
  
        expect { delete :destroy, params: { id: task.id } }.to change(Task, :count).by(-1)
      end
  
  
      it "rediret to tasks" do
        login(random_user)
        task = current_user.tasks.create(attributes_for(:task))
  
        delete :destroy, params: { id: task.id }
        expect(response).to redirect_to tasks_path
      end
    end
  end
  
  
  
end